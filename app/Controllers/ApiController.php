<?php

namespace App\Controllers;

use App\Models\InviteCode;
use App\Models\Node;
use App\Models\User;
use App\Services\Factory;
use App\Services\Config;
use App\Utils\Tools;
use App\Utils\Hash;
use App\Utils\Helper;
use App\Services\Auth;
use App\Models\LoginIp;
use App\Utils\Wecenter;
use App\Utils\Geetest;
use App\Utils\GA;
/**
 *  ApiController
 */

class ApiController extends BaseController
{
    public function index()
    {
    }

    public function token($request, $response, $args)
    {
        $accessToken = $id = $args['token'];
        $storage = Factory::createTokenStorage();
        $token = $storage->get($accessToken);
        if ($token==null) {
            $res['ret'] = 0;
            $res['msg'] = "token is null";
            return $this->echoJson($response, $res);
        }
        $res['ret'] = 1;
        $res['msg'] = "ok";
        $res['data'] = $token;
        return $this->echoJson($response, $res);
    }

    public function newToken($request, $response, $args)
    {
        // $data = $request->post('sdf');
        $email =  $request->getParam('email');

        $email = strtolower($email);
        $passwd = $request->getParam('passwd');

        // Handle Login
        $user = User::where('email', '=', $email)->first();

        if ($user == null) {
            $res['ret'] = 0;
            $res['msg'] = "401 邮箱或者密码错误";
            return $this->echoJson($response, $res);
        }

        if (!Hash::checkPassword($user->pass, $passwd)) {
            $res['ret'] = 0;
            $res['msg'] = "402 邮箱或者密码错误";
            return $this->echoJson($response, $res);
        }
        $tokenStr = Tools::genToken();
        $storage = Factory::createTokenStorage();
        $expireTime = time() + 3600*24*7;
        if ($storage->store($tokenStr, $user, $expireTime)) {
            $res['ret'] = 1;
            $res['msg'] = "ok";
            $res['data']['token'] = $tokenStr;
            $res['data']['user_id'] = $user->id;
            return $this->echoJson($response, $res);
        }
        $res['ret'] = 0;
        $res['msg'] = "system error";
        return $this->echoJson($response, $res);
    }

    public function node($request, $response, $args)
    {
        $accessToken = Helper::getTokenFromReq($request);
        $storage = Factory::createTokenStorage();
        $token = $storage->get($accessToken);
        $user = User::find($token->userId);
        $nodes = Node::where('sort', 0)->where("type", "1")->where(
            function ($query) use ($user) {
                $query->where("node_group", "=", $user->node_group)
                    ->orWhere("node_group", "=", 0);
            }
        )->get();

        $mu_nodes = Node::where('sort', 9)->where('node_class', '<=', $user->class)->where("type", "1")->where(
            function ($query) use ($user) {
                $query->where("node_group", "=", $user->node_group)
                    ->orWhere("node_group", "=", 0);
            }
        )->get();

        $temparray=array();
        foreach ($nodes as $node) {
            if ($node->mu_only == 0) {
                array_push($temparray, array("remarks"=>$node->name,
                                            "server"=>$node->server,
                                            "server_port"=>$user->port,
                                            "method"=>($node->custom_method==1?$user->method:$node->method),
                                            "obfs"=>str_replace("_compatible", "", (($node->custom_rss==1&&!($user->obfs=='plain'&&$user->protocol=='origin'))?$user->obfs:"plain")),
                                            "obfsparam"=>(($node->custom_rss==1&&!($user->obfs=='plain'&&$user->protocol=='origin'))?$user->obfs_param:""),
                                            "remarks_base64"=>base64_encode($node->name),
                                            "password"=>$user->passwd,
                                            "tcp_over_udp"=>false,
                                            "udp_over_tcp"=>false,
                                            "group"=>Config::get('appName'),
                                            "protocol"=>str_replace("_compatible", "", (($node->custom_rss==1&&!($user->obfs=='plain'&&$user->protocol=='origin'))?$user->protocol:"origin")),
                                            "obfs_udp"=>false,
                                            "enable"=>true));
            }

            if ($node->custom_rss == 1) {
                foreach ($mu_nodes as $mu_node) {
                    $mu_user = User::where('port', '=', $mu_node->server)->first();
                    $mu_user->obfs_param = $user->getMuMd5();

                    array_push($temparray, array("remarks"=>$node->name."- ".$mu_node->server." 端口",
                                        "server"=>$node->server,
                                        "server_port"=>$mu_user->port,
                                        "method"=>$mu_user->method,
                                        "group"=>Config::get('appName'),
                                        "obfs"=>str_replace("_compatible", "", (($node->custom_rss==1&&!($mu_user->obfs=='plain'&&$mu_user->protocol=='origin'))?$mu_user->obfs:"plain")),
                                        "obfsparam"=>(($node->custom_rss==1&&!($mu_user->obfs=='plain'&&$mu_user->protocol=='origin'))?$mu_user->obfs_param:""),
                                        "remarks_base64"=>base64_encode($node->name."- ".$mu_node->server." 端口"),
                                        "password"=>$mu_user->passwd,
                                        "tcp_over_udp"=>false,
                                        "udp_over_tcp"=>false,
                                        "protocol"=>str_replace("_compatible", "", (($node->custom_rss==1&&!($mu_user->obfs=='plain'&&$mu_user->protocol=='origin'))?$mu_user->protocol:"origin")),
                                        "obfs_udp"=>false,
                                        "enable"=>true));
                }
            }
        }

        $res['ret'] = 1;
        $res['msg'] = "ok";
        $res['data'] = $temparray;
        return $this->echoJson($response, $res);
    }

    public function userInfo($request, $response, $args)
    {
        $id = $args['id'];
        $accessToken = Helper::getTokenFromReq($request);
        $storage = Factory::createTokenStorage();
        $token = $storage->get($accessToken);
        if ($id != $token->userId) {
            $res['ret'] = 0;
            $res['msg'] = "access denied";
            return $this->echoJson($response, $res);
        }
        $user = User::find($token->userId);
        $user->pass = null;
        $data = $user;
        $res['ret'] = 1;
        $res['msg'] = "ok";
        $res['data'] = $data;
        return $this->echoJson($response, $res);
    }

   public function getInfo($request, $response, $args)
    {
     $user = Auth::getUser();
     $accessToken = Helper::getTokenFromReq($request);
     if ($user->isLogin==false || $user->ga_token != $accessToken) {
        $res['ret'] = 0;
        $res['msg'] = "access denied";
        return $this->echoJson($response, $res);
     }
        $user->pass = null;
        $data = $user;
        $res['ret'] = 1;
        $res['msg'] = "ok";
        $res['user_info'] = $data;
        return $this->echoJson($response, $res);
    }

  public function login($request, $response, $args){
    //是否是登录
    $user = Auth::getUser();
    $base_url = Config::get('baseUrl');
    $shops = Shop::where("status", 1)->paginate(15, ['*'], 'page', $pageNum);
    $nodes = Node::where('sort', 0)->where("type", "1")->where(
          function ($query) use ($user) {
              $query->where("node_group", "=", $user->node_group)
                  ->orWhere("node_group", "=", 0);
          }
      )->get();
    if ($user->isLogin) {

      $total1 = $user->u + $user->d;
      $transfer_enable1 = $user->transfer_enable;

      $rest['ret'] = 1;
      $rest['msg'] = "您已经登录";
      $rest['user_info'] = $user;
      $rest['bandwidth'] = Tools::flowAutoShow($transfer_enable1 - $total1);
      //get other info
      $rest['link'] = $base_url.'/link/'.LinkController::GenerateSSRSubCode($user->id, 0).'?mu=1';
      //$rest['other'] = [
      		//'ssr_sub_token' =>  LinkController::GenerateSSRSubCode($user->id, 0),
        	//'base_url' => $base_url
      //];
      return $this->echoJson($response, $rest);
    }
    $params = $request->getQueryParams();
    //check email & passwd
    if (!isset($params['email']) || !isset($params['passwd'])) {
        $res['ret'] = 0;
        $res['msg'] = "data error";
        return $this->echoJson($response, $res);
    }
    $email = strtolower($params['email']);
    $passwd = $params['passwd'];
    $code = $params['code'];
    $rememberMe = $params['remember_me'];

    //login check
    if (Config::get('enable_geetest_login') == 'true') {
      $ret = Geetest::verify($params['geetest_challenge'], $params['geetest_validate'], $params['geetest_seccode']);
      if (!$ret) {
        $res['ret'] = 0;
        $res['msg'] = "系统无法接受您的验证结果，请刷新页面后重试。";
        return $this->echoJson($response, $res);
      }
    }
    // Handle Login
    $user = User::where('email', '=', $email)->first();
    if ($user == null) {
      $rs['ret'] = 0;
      $rs['msg'] = "401 邮箱或者密码错误";
      return $this->echoJson($response, $rs);
    }
    if (!Hash::checkPassword($user->pass, $passwd)) {
      $rs['ret'] = 0;
      $rs['msg'] = "402 邮箱或者密码错误";
      $loginip=new LoginIp();
      $loginip->ip=$_SERVER["REMOTE_ADDR"];
      $loginip->userid=$user->id;
      $loginip->datetime=time();
      $loginip->type=1;
      $loginip->save();
      return $this->echoJson($response, $rs);
    }
    // @todo
    $time =  3600*24;
    if ($rememberMe) {
      $time = 3600*24*7;
    }
    if ($user->ga_enable==1) {
      $ga = new GA();
      $rcode = $ga->verifyCode($user->ga_token, $code);
      if (!$rcode) {
        $res['ret'] = 0;
        $res['msg'] = "403 两步验证码错误，如果您是丢失了生成器或者错误地设置了这个选项，您可以尝试重置密码，即可取消这个选项。";
        return $this->echoJson($response, $res);
      }
    }

    Auth::login($user->id, $time);
    $rs['ret'] = 1;
    $rs['msg'] = "欢迎回来";

    $loginip=new LoginIp();
    $loginip->ip=$_SERVER["REMOTE_ADDR"];
    $loginip->userid=$user->id;
    $loginip->datetime=time();
    $loginip->type=0;
    $loginip->save();

    Wecenter::add($user, $passwd);
    Wecenter::Login($user, $passwd, $time);
    //get use info
    $total1 = $user->u + $user->d;
    $transfer_enable1 = $user->transfer_enable;

    $rs['user_info'] = $user;
    $rs['bandwidth'] = Tools::flowAutoShow($transfer_enable1 - $total1);
    $rs['link'] = $base_url.'/link/'.LinkController::GenerateSSRSubCode($user->id, 0).'?mu=1';
    //get other info
    //$rs['other'] = [
      //'ssr_sub_token' =>  LinkController::GenerateSSRSubCode($user->id, 0),
      //'base_url' => $base_url
     //];
    //get shop info
    //$rs['shop_info'] = $shops;
    return $this->echoJson($response, $rs);
  }

  public function getShop($request, $response, $args){
     $user = Auth::getUser();
     if ($user->isLogin==false) {
        $res['ret'] = 0;
        $res['msg'] = "access denied";
        return $this->echoJson($response, $res);
     }

    $shops = Shop::where("status", 1)->paginate(15, ['*'], 'page', $pageNum);
    $res['ret'] = 1;
    $res['msg'] = "ok";
    $res['shop'] = $shops;
    return $this->echoJson($response, $res);
    }

}
