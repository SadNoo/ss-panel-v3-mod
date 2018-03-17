<?php

namespace App\Middleware;

use Psr\Http\Message\ServerRequestInterface;
use Psr\Http\Message\ResponseInterface;
use App\Services\Factory;
use App\Utils\Helper;

class Api
{
    public function __invoke(ServerRequestInterface $request, ResponseInterface $response, $next)
    {
        $response = $response->withHeader('Access-Control-Allow-Origin', '*'); 
        //获取当前访问action
        $url = explode('?',$_SERVER['REQUEST_URI'])[0];
        //是否是api 登录
        if (in_array($url,['/api/login','/api/get-shop'])) {
          $response = $next($request, $response);
          return $response;
        }
      
        $accessToken = Helper::getTokenFromReq($request);
        if ($accessToken==null) {
            $res['ret'] = 0;
            $res['msg'] = "token is null";
            $response->getBody()->write(json_encode($res));
            return $response;
        }
        $storage = Factory::createTokenStorage();
        $token = $storage->get($accessToken);
        if ($token==null) {
            $res['ret'] = 0;
            $res['msg'] = "token is null";
            $response->getBody()->write(json_encode($res));
            return $response;
        }
        if ($token->expireTime < time()) {
            $res['ret'] = 0;
            $res['msg'] = "token is expire";
            $response->getBody()->write(json_encode($res));
            return $response;
        }
        $response = $next($request, $response);
        return $response;
    }
  
   public function allowAction() {
    return [
      '/api/get-info',
        '/api/get-shop'
    ];
  }
}
