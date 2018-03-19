





{include file='user/main.tpl'}

{$ssr_prefer = URL::SSRCanConnect($user, 0)}


	<main class="content">
		<div class="content-header ui-content-header">
			<div class="container">
				<h1 class="content-heading">用户中心</h1>
			</div>
		</div>
		<div class="container">
			<section class="content-inner margin-top-no">
				<div class="ui-card-wrap">

						<div class="col-lg-6 col-md-6">

							<div class="card">
								<div class="card-main">
									<div class="card-inner margin-bottom-no">
										<p class="card-heading"><a href="/user/announcement"/>公告面板</a></p>
										<p><a href="https://github.com/lhie1/tuClub/blob/master/README.md#tuclub-简介">本站简介</a></p>
										<p><a href="lhie1x@gmail.com">发送邮件</a> / <a href="https://t.me/tuClub">在线联系</a> / <a href="https://telegram.me/tuClub">交流群组</a> / <a href="https://t.me/tuClubNews">公告中心</a></p><br>
										<p>本站：兼容<code>SS/SSR</code>；支持<code>Surge/SSR</code>托管订阅</p><br>
										{if $ann != null}
										<p>{$ann->content}</p>
										{/if}
									</div>

								</div>
							</div>

							<div class="card">
								<div class="card-main">
									<div class="card-inner margin-bottom-no">
										<p class="card-heading">All-in-One (快速配置指导)</p>
										<p>您可以在这里查看您的信息。<br>同时，这里为您提供了自动化地配置文件生成，包含了所有节点信息，方便您在诸多的服务器中快速添加，快速切换。</p>
										<nav class="tab-nav margin-top-no">
											<ul class="nav nav-list">
												<li {if $ssr_prefer}class="active"{/if}>
													<a class="waves-attach" data-toggle="tab" href="#all_ssr"><i class="icon icon-lg">airplanemode_active</i>&nbsp;ShadowsocksR（荐）</a>
												</li>
												<li {if !$ssr_prefer}class="active"{/if}>
													<a class="waves-attach" data-toggle="tab" href="#all_ss"><i class="icon icon-lg">flight_takeoff</i>&nbsp;Shadowsocks</a>
												</li>
											</ul>
										</nav>
										<div class="card-inner">
											<div class="tab-content">
												<div class="tab-pane fade {if $ssr_prefer}active in{/if}" id="all_ssr">
													{$pre_user = URL::cloneUser($user)}

													<nav class="tab-nav margin-top-no">
														<ul class="nav nav-list">
															<li class="active">
																<a class="waves-attach" data-toggle="tab" href="#all_ssr_info"><i class="icon icon-lg">info_outline</i>&nbsp;信息</a>
															</li>
															<li>
																<a class="waves-attach" data-toggle="tab" href="#all_ssr_windows"><i class="icon icon-lg">desktop_windows</i>&nbsp;Windows</a>
															</li>
															<li>
																<a class="waves-attach" data-toggle="tab" href="#all_ssr_mac"><i class="icon icon-lg">laptop_mac</i>&nbsp;MacOS</a>
															</li>
															<li>
																<a class="waves-attach" data-toggle="tab" href="#all_ssr_ios"><i class="icon icon-lg">laptop_mac</i>&nbsp;iOS</a>
															</li>
															<li>
																<a class="waves-attach" data-toggle="tab" href="#all_ssr_android"><i class="icon icon-lg">android</i>&nbsp;Android</a>
															</li>
															<li>
																<a class="waves-attach" data-toggle="tab" href="#all_ssr_router"><i class="icon icon-lg">router</i>&nbsp;路由器</a>
															</li>
														</ul>
													</nav>
													<div class="tab-pane fade active in" id="all_ssr_info">
														{$user = URL::getSSRConnectInfo($pre_user)}
														{$ssr_url_all = URL::getAllUrl($pre_user, 0, 0)}
														{$ssr_url_all_mu = URL::getAllUrl($pre_user, 1, 0)}
														{if URL::SSRCanConnect($user)}
														<dl class="dl-horizontal">
															<p><dt>端口</dt>
															<dd>{$user->port}</dd></p>

															<p><dt>密码</dt>
															<dd>{$user->passwd}</dd></p>

															<p><dt>加密</dt>
															<dd>{$user->method}</dd></p>

															<p><dt>协议</dt>
															<dd>{$user->protocol}</dd></p>

															<p><dt>混淆</dt>
															<dd>{$user->obfs}</dd></p>
														</dl>
														{else}
															<p>您目前的加密方式、协议、混淆，使用<code>普通端口</code>无法在 <code>SSR 客户端</code>下连接。请您使用<code>固定端口模式</code>或选用 <code>SS 客户端</code>来连接，或者到 资料编辑 页面修改后再来查看此处。<br><br>
															<p>SSR 固定端口订阅地址：<br>
															<code>{$baseUrl}/link/{$ssr_sub_token}?mu=1</code></p></p></p>
														{/if}
													</div>
													<div class="tab-pane fade" id="all_ssr_windows">
														<p>下载：<a href="http://omgib13x8.bkt.clouddn.com/ssr-win.7z">客户端</a><br><br>
														右键<code>ShadowsocksR</code>托盘图标 -> SSR服务器订阅 -> SSR 服务器订阅设置，将订阅地址填入地址后面的编辑框，点击确定。<br><br>
														获取节点：服务器 -> 更新 SSR 服务器订阅（不通过代理）<br><br>
														建议：系统代理 -> 模式 -> 全局模式/Pac模式；代理规则 -> 绕过局域网和大陆</p>
														<br>游戏/特殊：<a href="http://omgib13x8.bkt.clouddn.com/ssr-tap.7z">SS-Tap</a><br>
													</div>
													<div class="tab-pane fade" id="all_ssr_mac">
														<p>下载：<a href="http://omgib13x8.bkt.clouddn.com/ssr-mac.dmg">客户端</a><br><br>
														右键<code>ShadowsocksR</code>的托盘图标 -> 服务器 -> 编辑订阅，点击<code>+</code>，将订阅地址填入订阅地址后面的编辑框，点击<code>OK</code>。<br><br>
														获取节点：服务器 -> 手动更新订阅<br><br>
														建议：白名单模式/Pac模式</p>
													</div>
													<div class="tab-pane fade" id="all_ssr_ios">
														<p>客户端：Shadowrocket<br>（联系 admin@lhie1.com 获取下载方式）<br><br>打开客户端，点击首页的右上角的`+`，选择类型：Subscribe，将订阅地址填入`URL`后面的编辑框，点击完成<br><br>
														自动更新节点：设置 -> 服务器订阅 -> 打开时更新<br><br>
														推荐：全局路由 -> 配置</p>
													</div>
													<div class="tab-pane fade" id="all_ssr_android">
														<p>下载客户端：<a href="http://omgib13x8.bkt.clouddn.com/ssr-android.apk">客户端</a><br><br>
														点击应用顶部的<code>ShadowsocksR ⬇️</code> -> 点击<code>+</code> -> 添加/升级 SSR 订阅，将订阅地址填入并添加，点击确定并升级。<br><br>
														建议：打开 UDP 转发；打开 TCP Fast Open ；路由：绕过局域网和中国大陆地址<br><br>
														ACL：<br><code>https://raw.githubusercontent.com/ACL4SSR/ACL4SSR/master/banAD.acl</code></p>
													</div>
													<div class="tab-pane fade" id="all_ssr_router">
														<p>刷入<a href="http://www.right.com.cn/forum/thread-161324-1-1.html">此帖的固件</a>，然后将订阅地址导入即可。</p>
													</div>
												</div>
												<div class="tab-pane fade {if !$ssr_prefer}active in{/if}" id="all_ss">
													<nav class="tab-nav margin-top-no">
														<ul class="nav nav-list">
															<li class="active">
																<a class="waves-attach" data-toggle="tab" href="#all_ss_info"><i class="icon icon-lg">info_outline</i>&nbsp;信息</a>
															</li>
															<li>
																<a class="waves-attach" data-toggle="tab" href="#all_ss_windows"><i class="icon icon-lg">desktop_windows</i>&nbsp;Windows</a>
															</li>
															<li>
																<a class="waves-attach" data-toggle="tab" href="#all_ss_mac"><i class="icon icon-lg">laptop_mac</i>&nbsp;MacOS</a>
															</li>
															<li>
																<a class="waves-attach" data-toggle="tab" href="#all_ss_ios"><i class="icon icon-lg">laptop_mac</i>&nbsp;iOS</a>
															</li>
															<li>
																<a class="waves-attach" data-toggle="tab" href="#all_ss_android"><i class="icon icon-lg">android</i>&nbsp;Android</a>
															</li>
															<li>
																<a class="waves-attach" data-toggle="tab" href="#all_ss_router"><i class="icon icon-lg">router</i>&nbsp;路由器</a>
															</li>
														</ul>
													</nav>
													<div class="tab-pane fade active in" id="all_ss_info">
														{$user = URL::getSSConnectInfo($pre_user)}
														{$ss_url_all = URL::getAllUrl($pre_user, 0, 1)}
														{$ss_url_all_mu = URL::getAllUrl($pre_user, 1, 1)}
														{$ss_url_all_win = URL::getAllUrl($pre_user, 0, 2)}

														{if URL::SSCanConnect($user)}
														<dl class="dl-horizontal">
															<p>各个节点的地址请到节点列表查看！</p>

															<p><dt>端口</dt>
															<dd>{$user->port}</dd></p>

															<p><dt>密码</dt>
															<dd>{$user->passwd}</dd></p>

															<p><dt>加密</dt>
															<dd>{$user->method}</dd></p>

															<p><dt>协议</dt>
															<dd>{$user->protocol}</dd></p>

															<p><dt>混淆</dt>
															<dd>{$user->obfs}</dd></p>
														</dl>
														{else}
															<p>您目前的加密方式、协议、混淆无法在 <code>SS 客户端</code>下连接。请您选用 SSR 客户端来连接，或者到 资料编辑 页面修改后再来查看此处。</p>
														{/if}
													</div>
													<div class="tab-pane fade" id="all_ss_windows">
														<p>下载：<a href="http://omgib13x8.bkt.clouddn.com/ss-win.zip">客户端</a><br><br>
															您有两种方式导入节点：<br><br>
														（1）<a href="/user/getpcconf?is_mu=0&is_ss=1">下载节点信息配置文件</a>，保存至`Shadowsocks`的目录下，打开`Shadowsocks`即载入所有节点信息。<br>
														（2）<a class="copy-text" data-clipboard-text="{$ss_url_all_win}">复制节点信息到剪切板</a>, 右键`Shadowsocks`的托盘图标 -> 从剪贴板导入 URL<br><br>
														推荐：系统代理模式 -> Pac 模式<br><br>
														Obfs：<br>
														插件：obfs-local<br>
														插件选项：obfs=tls;obfs-host=cloudfront.net</p><br>
														<p>———————————————————————————————
														<br><br>游戏/特殊：<a href="http://omgib13x8.bkt.clouddn.com/ssr-tap.7z">SS-Tap</a><br>
													</div>
													<div class="tab-pane fade" id="all_ss_mac">
														<p>下载：<a href="http://omgib13x8.bkt.clouddn.com/ss-mac.zip">客户端</a><br><br>
														<a href="/user/getpcconf?is_mu=0&is_ss=1">下载节点信息配置文件</a>，右键`Shadowsocks`的托盘图标 -> 服务器列表 -> 导入服务器配置文件...，选择这个文件（gui-config.json<br><br>
														推荐：Pac模式<br></p>
													</div>
													<div class="tab-pane fade" id="all_ss_ios">
														<p>推荐使用 <code>Workflow</code> 导入Surge：<br><br><a href="https://workflow.is/workflows/3a32d2bf7750466da15749eedc60ea18">🐰 User Data</a> / <a href="https://workflow.is/workflows/df5a74a8efb14218ba15fe64d94fa9f5">Rule OTA</a></p>
													</div>
													<div class="tab-pane fade" id="all_ss_android">
														<p>下载：<a href="http://omgib13x8.bkt.clouddn.com/ss-android.apk">客户端</a> 和 <a href="http://omgib13x8.bkt.clouddn.com/ss-android-obfs.apk">插件</a><br><br>
														<a class="copy-text" data-clipboard-text="{$ss_url_all}">复制节点信息到剪切板</a>，点击应用右上角的`+`，选择从剪贴板导入，选择任意节点，点击右下角的纸飞机按钮即可科学上网<br><br>
														推荐：路由：绕过局域网及中国大陆地址<br><br>
														Obfs：<br>
														插件：obfs-local<br>
														插件选项：obfs=tls;obfs-host=cloudfront.net</p><br>
													</div>
													<div class="tab-pane fade" id="all_ss_router">
														<p>路由器 刷入<a href="http://www.right.com.cn/forum/thread-161324-1-1.html">此帖的固件</a>，然后 SSH 登陆路由器，执行以下命令：<br>
														<code>wget -O- {$baseUrl}/link/{$router_token}?is_ss=1 | bash && echo -e "\n0 */3 * * * wget -O- {$baseUrl}/link/{$router_token}?is_ss=1 | bash\n">> /etc/storage/cron/crontabs/admin && killall crond && crond </code><br><br>
														执行完毕以后就可以到路由器的设置面板里随意选择 Shadowsocks 服务器进行连接了。<br><br>
														离线安装包：<a href="/ssr-branch/ss-merlin.tar">SS-Merlin</a></p>
													</div>
												</div>
											</div>
										</div>
										<div class="card-action">
											<div class="card-action-btn pull-left">
												<p>SSR 普通端口订阅地址：<br>
													<code>{$baseUrl}/link/{$ssr_sub_token}?mu=0</code></p>
												<p>SSR 固定端口订阅地址：<br>
													<code>{$baseUrl}/link/{$ssr_sub_token}?mu=1</code></p>
												<p>Surge 托管地址：<br>
													<code>{$baseUrl}/link/{$ios_token}?is_ss=1</code></p><br>
												<p>使用<code>Workflow</code>导入（Surge / Shadowrcoket）：<br><br>
													<a href="https://workflow.is/workflows/3a32d2bf7750466da15749eedc60ea18">🐰 User Data</a> / <a href="https://workflow.is/workflows/df5a74a8efb14218ba15fe64d94fa9f5">Rule OTA</a><br><br>
												<p>兼容：<code>Surge</code>使用普通端口模式 | <code>SSR</code>使用固定端口模式</p>
												<p>备注：除 <code>Surge 客户端</code> 都建议使用 <code>SSR 客户端 + SSR 订阅</code></p>
												<p>备注：<code>SSR 普通端口</code>与<code>SSR 固定端口</code>在实际使用中无差别</p>
												<p>备注：使用<code>Surge 托管地址</code>之前请使用<code>Workflow</code>运行一次</p><br>
												<p><a class="btn btn-brand btn-flat waves-attach" href="/user/url_reset"><span class="icon">close</span>&nbsp;重置所有链接</a></p>
											</div>
										</div>
									</div>

								</div>
							</div>
						</div>

						<div class="col-lg-6 col-md-6">

							<div class="card">
								<div class="card-main">
									<div class="card-inner margin-bottom-no">
										<p class="card-heading">帐号使用情况</p>
										<dl class="dl-horizontal">
											<p><dt>帐号等级</dt>
											<dd>{$user->class}</dd></p>

											<p><dt>到期时间</dt>
											<dd>{$user->class_expire}</dd></p>

											<p><dt>速度限制</dt>
											{if $user->node_speedlimit!=0}
											<dd>{$user->node_speedlimit}Mbps</dd>
											{else}
											<dd>不限速</dd>
											{/if}</p>

											<p><dt>上次使用</dt>
											<dd>{$user->lastSsTime()}</dd></p>
										</dl>
									</div>

								</div>
							</div>

							<div class="card">
								<div class="card-main">
									<div class="card-inner margin-bottom-no">

										<div id="traffic_chart" style="height: 300px; width: 100%;"></div>

										<script src="//cdn.staticfile.org/canvasjs/1.7.0/canvasjs.js"></script>
										<script type="text/javascript">
											var chart = new CanvasJS.Chart("traffic_chart",
											{
												title:{
													text: "流量使用情况",
													fontFamily: "Impact",
													fontWeight: "normal"
												},

												legend:{
													verticalAlign: "bottom",
													horizontalAlign: "center"
												},
												data: [
												{
													//startAngle: 45,
													indexLabelFontSize: 20,
													indexLabelFontFamily: "Garamond",
													indexLabelFontColor: "darkgrey",
													indexLabelLineColor: "darkgrey",
													indexLabelPlacement: "outside",
													type: "doughnut",
													showInLegend: true,
													dataPoints: [
														{if $user->transfer_enable != 0}
														{
															y: {$user->last_day_t/$user->transfer_enable*100}, legendText:"已用 {number_format($user->last_day_t/$user->transfer_enable*100,2)}% {$user->LastusedTraffic()}", indexLabel: "已用 {number_format($user->last_day_t/$user->transfer_enable*100,2)}% {$user->LastusedTraffic()}"
														},
														{
															y: {($user->u+$user->d-$user->last_day_t)/$user->transfer_enable*100}, legendText:"今日 {number_format(($user->u+$user->d-$user->last_day_t)/$user->transfer_enable*100,2)}% {$user->TodayusedTraffic()}", indexLabel: "今日 {number_format(($user->u+$user->d-$user->last_day_t)/$user->transfer_enable*100,2)}% {$user->TodayusedTraffic()}"
														},
														{
															y: {($user->transfer_enable-($user->u+$user->d))/$user->transfer_enable*100}, legendText:"剩余 {number_format(($user->transfer_enable-($user->u+$user->d))/$user->transfer_enable*100,2)}% {$user->unusedTraffic()}", indexLabel: "剩余 {number_format(($user->transfer_enable-($user->u+$user->d))/$user->transfer_enable*100,2)}% {$user->unusedTraffic()}"
														}
														{/if}
													]
												}
												]
											});

											chart.render();
										</script>

									</div>

								</div>
							</div>



							<div class="card">
								<div class="card-main">
									<div class="card-inner margin-bottom-no">
										<p class="card-heading">签到获取流量</p>
											<p>每次签到可以获取{$config['checkinMin']}~{$config['checkinMax']}MB流量。</p>

											<p>每天可以签到一次。您可以点击按钮或者摇动手机来签到。</p>

											<p>上次签到时间：<code>{$user->lastCheckInTime()}</code></p>

											<p id="checkin-msg"></p>

											{if $geetest_html != null}
												<div id="popup-captcha"></div>
											{/if}
									</div>

									<div class="card-action">
										<div class="card-action-btn pull-left">
											{if $user->isAbleToCheckin() }
											{if $user->class !=0}
												<p id="checkin-btn">
														<button id="checkin" class="btn btn-brand btn-flat waves-attach"><span class="icon">check</span>&nbsp;签到</button>
													</p>
											{else}
												<p><a class="btn btn-brand disabled btn-flat waves-attach" href="#"><span class="icon">check</span>&nbsp;不能签到</a></p>
											{/if}
											{else}
												<p><a class="btn btn-brand disabled btn-flat waves-attach" href="#"><span class="icon">check</span>&nbsp;未购买不能签到</a></p>
											{/if}
										</div>
									</div>

								</div>
							</div>


						{if $enable_duoshuo=='true'}

							<div class="card">
								<div class="card-main">
									<div class="card-inner margin-bottom-no">
										<p class="card-heading">讨论区</p>
											<div class="ds-thread" data-thread-key="0" data-title="index" data-url="{$baseUrl}/user/"></div>
											<script type="text/javascript">
											var duoshuoQuery = {

											short_name:"{$duoshuo_shortname}"


											};
												(function() {
													var ds = document.createElement('script');
													ds.type = 'text/javascript';ds.async = true;
													ds.src = (document.location.protocol == 'https:' ? 'https:' : 'http:') + '//static.duoshuo.com/embed.js';
													ds.charset = 'UTF-8';
													(document.getElementsByTagName('head')[0]
													 || document.getElementsByTagName('body')[0]).appendChild(ds);
												})();
											</script>
									</div>

								</div>
							</div>

						{/if}

						{include file='dialog.tpl'}

					</div>


				</div>
			</section>
		</div>
	</main>







{include file='user/footer.tpl'}

<script src="/theme/material/js/shake.js/shake.js"></script>


<script>

$(function(){
	new Clipboard('.copy-text');
});

$(".copy-text").click(function () {
	$("#result").modal();
	$("#msg").html("已复制到您的剪贴板，请您继续接下来的操作。");
});

{if $geetest_html == null}


window.onload = function() {
    var myShakeEvent = new Shake({
        threshold: 15
    });

    myShakeEvent.start();

    window.addEventListener('shake', shakeEventDidOccur, false);

    function shakeEventDidOccur () {
		if("vibrate" in navigator){
			navigator.vibrate(500);
		}

        $.ajax({
                type: "POST",
                url: "/user/checkin",
                dataType: "json",
                success: function (data) {
                    $("#checkin-msg").html(data.msg);
                    $("#checkin-btn").hide();
					$("#result").modal();
                    $("#msg").html(data.msg);
                },
                error: function (jqXHR) {
					$("#result").modal();
                    $("#msg").html("发生错误：" + jqXHR.status);
                }
            });
    }
};


$(document).ready(function () {
	$("#checkin").click(function () {
		$.ajax({
			type: "POST",
			url: "/user/checkin",
			dataType: "json",
			success: function (data) {
				$("#checkin-msg").html(data.msg);
				$("#checkin-btn").hide();
				$("#result").modal();
				$("#msg").html(data.msg);
			},
			error: function (jqXHR) {
				$("#result").modal();
				$("#msg").html("发生错误：" + jqXHR.status);
			}
		})
	})
})


{else}


window.onload = function() {
    var myShakeEvent = new Shake({
        threshold: 15
    });

    myShakeEvent.start();

    window.addEventListener('shake', shakeEventDidOccur, false);

    function shakeEventDidOccur () {
		if("vibrate" in navigator){
			navigator.vibrate(500);
		}

        c.show();
    }
};



var handlerPopup = function (captchaObj) {
	c = captchaObj;
	captchaObj.onSuccess(function () {
		var validate = captchaObj.getValidate();
		$.ajax({
			url: "/user/checkin", // 进行二次验证
			type: "post",
			dataType: "json",
			data: {
				// 二次验证所需的三个值
				geetest_challenge: validate.geetest_challenge,
				geetest_validate: validate.geetest_validate,
				geetest_seccode: validate.geetest_seccode
			},
			success: function (data) {
				$("#checkin-msg").html(data.msg);
				$("#checkin-btn").hide();
				$("#result").modal();
				$("#msg").html(data.msg);
			},
			error: function (jqXHR) {
				$("#result").modal();
				$("#msg").html("发生错误：" + jqXHR.status);
			}
		});
	});
	// 弹出式需要绑定触发验证码弹出按钮
	captchaObj.bindOn("#checkin");
	// 将验证码加到id为captcha的元素里
	captchaObj.appendTo("#popup-captcha");
	// 更多接口参考：http://www.geetest.com/install/sections/idx-client-sdk.html
};

initGeetest({
	gt: "{$geetest_html->gt}",
	challenge: "{$geetest_html->challenge}",
	product: "popup", // 产品形式，包括：float，embed，popup。注意只对PC版验证码有效
	offline: {if $geetest_html->success}0{else}1{/if} // 表示用户后台检测极验服务器是否宕机，与SDK配合，用户一般不需要关注
}, handlerPopup);



{/if}


</script>
