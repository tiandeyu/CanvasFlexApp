<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="canvas.SignedRequest" %>
<%@ page import="java.util.Map" %>
<%
    // Pull the signed request out of the request body and verify/decode it.
    Map<String, String[]> parameters = request.getParameterMap();
    String[] signedRequest = parameters.get("signed_request");
    if (signedRequest == null) {%>
This App must be invoked via a signed request!<%
        return;
    }
    //String yourConsumerSecret = System.getenv("CANVAS_CONSUMER_SECRET");
    String yourConsumerSecret="4036723412891430066";
    String signedRequestJson = SignedRequest.verifyAndDecodeAsJson(signedRequest[0], yourConsumerSecret);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>

    <title>Hello World Canvas Example</title>

    <link rel="stylesheet" type="text/css" href="/sdk/css/canvas.css" />

    <!-- Include all the canvas JS dependencies in one file -->
    <script type="text/javascript" src="/sdk/js/canvas-all.js"></script>
    <!-- Third part libraries, substitute with your own -->
    <script type="text/javascript" src="/scripts/json2.js"></script>


    <!-- flash -->
    <meta name="google" value="notranslate" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" href="/HelloWorld/bin-debug/styles.css" type="text/css" />
    <link rel="stylesheet" type="text/css" href="/HelloWorld/bin-debug/history/history.css" />
    <script type="text/javascript" src="/HelloWorld/bin-debug/history/history.js"></script>
    <script type="text/javascript" src="/HelloWorld/bin-debug/swfobject.js"></script>
    <script type="text/javascript">
        var orderNo;
        if (self === top) {
            // Not in Iframe
            alert("This canvas app must be included within an iframe");
        }

        Sfdc.canvas(function() {
            var sr = JSON.parse('<%=signedRequestJson%>');
            // Save the token
            Sfdc.canvas.oauth.token(sr.oauthToken);
            Sfdc.canvas.byId('username').innerHTML = sr.context.user.fullName;
            Sfdc.canvas.byId('data').innerHTML = sr.context.environment.parameters.p1;
            orderNo = sr.context.environment.parameters.p1;

            // For version detection, set to min. required Flash Player version,
            //or 0 (or 0.0.0), for no version detection.
            var swfVersionStr = "11.1.0";
            // To use express install, set to playerProductInstall.swf,
            //otherwise the empty string.
            var xiSwfUrlStr = "/HelloWorld/bin-debug/playerProductInstall.swf";
            var flashvars = {};
            flashvars.orderNo = orderNo;
            var params = {};
            params.quality = "high";
            params.bgcolor = "#ffffff";
            params.allowscriptaccess = "sameDomain";
            params.allowfullscreen = "true";
            var attributes = {};
            attributes.id = "HelloWorld";
            attributes.name = "HelloWorld";
            attributes.align = "middle";
            swfobject.embedSWF(
                    "/HelloWorld/bin-debug/HelloWorld.swf", "flashContent",
                    "100%", "100%",
                    swfVersionStr, xiSwfUrlStr,
                    flashvars, params, attributes);
            // JavaScript enabled so display the flashContent div in case
            //it is not replaced with a swf object.
            swfobject.createCSS("#flashContent", "display:block;text-align:left;");



        });






    </script>
    <!-- flash end -->
</head>
<body>
<br/>
<h1>Hello <span id='username'></span></h1>
<h1>Order No : <span id='data'></span></h1>
<div id="flashContent">
    <p style="margin:100px;">
    <table  width="700" cellpadding="10" cellspacing="2" border="0">
        <tr><td class="pluginHeader">Flash Player Required</td></tr>
        <tr><td class="pluginText">The Adobe Flash Player version
            10.2.0 or greater is required.</td></tr>
        <tr><td class = "pluginInstallText" align="left">
            <table border="0" width="100%">
                <tr class = "pluginInstallText" >
                    <td>Click here to download and install Adobe Flash Player:</td>
                    <td> </td>
                    <td align="right">	<script type="text/javascript">
                        var pageHost
                                =((document.location.protocol == "https:") ? "https://" : "http://");
                        document.write("<a target='_blank'"
                                +" href='http://get.adobe.com/flashplayer/'><"
                                +"img style='border-style: none' src='"
                                +pageHost
                                +"www.adobe.com/images/shared/download_buttons/get_flash_player.gif'"
                                +" alt='Get Adobe Flash player' /></a>" );
                    </script>
                    </td>
                </tr>
            </table>
        </td>
        </tr>
    </table>
    </p>
</div>
<noscript>
    <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
            width="100%" height="100%" id="HelloWorld">
        <param name="movie" value="/HelloWorld/bin-debug/HelloWorld.swf" />
        <param name="quality" value="high" />
        <param name="bgcolor" value="#ffffff" />
        <param name="allowScriptAccess" value="sameDomain" />
        <param name="allowFullScreen" value="true" />
        <!--[if !IE]>-->
        <object type="application/x-shockwave-flash" data="/HelloWorld/bin-debug/HelloWorld.swf"
                width="100%" height="100%">
            <param name="quality" value="high" />
            <param name="bgcolor" value="#ffffff" />
            <param name="allowScriptAccess" value="sameDomain" />
            <param name="allowFullScreen" value="true" />
            <!--<![endif]-->
            <!--[if gte IE 6]>-->
            <p>
            <p style="margin:100px;">
            <table  width="700" cellpadding="10" cellspacing="2" border="0">
                <tr><td class="pluginHeader">Flash Player Required</td></tr>
                <tr><td class="pluginText">The Adobe Flash Player version
                    10.2.0 or greater is required.</td></tr>
                <tr><td class = "pluginInstallText" align="left">
                    <table border="0" width="100%">
                        <tr class = "pluginInstallText" >
                            <td>Click here to download and install Adobe Flash Player:</td>
                            <td> </td>
                            <td align="right">	<script type="text/javascript">
                                var pageHost
                                        = ((document.location.protocol == "https:") ? "https://" : "http://");
                                document.write("<a target='_blank'"
                                        +" href='http://get.adobe.com/flashplayer/'><"
                                        +"img style='border-style: none' src='"
                                        +pageHost
                                        +"www.adobe.com/images/shared/download_buttons/get_flash_player.gif'"
                                        +" alt='Get Adobe Flash player' /></a>" );
                            </script>
                            </td>
                        </tr>
                    </table>
                </td>
                </tr>
            </table>
            </p>
            </p>
            <!--<![endif]-->
            <p style="margin:100px;">
            <table  width="700" cellpadding="10" cellspacing="2" border="0">
                <tr><td class="pluginHeader">Flash Player Required</td></tr>
                <tr><td class="pluginText">The Adobe Flash Player version
                    10.2.0 or greater is required.</td></tr>
                <tr><td class = "pluginInstallText" align="left">
                    <table border="0" width="100%">
                        <tr class = "pluginInstallText" >
                            <td>Click here to download and install Adobe Flash Player:</td>
                            <td> </td>
                            <td align="right">	<script type="text/javascript">
                                var pageHost
                                        = ((document.location.protocol == "https:") ? "https://" : "http://");
                                document.write("<a target='_blank'"
                                        +" href='http://get.adobe.com/flashplayer/'><"
                                        +"img style='border-style: none' src='"
                                        +pageHost
                                        +"www.adobe.com/images/shared/download_buttons/get_flash_player.gif'"
                                        +" alt='Get Adobe Flash player' /></a>" );
                            </script>
                            </td>
                        </tr>
                    </table>
                </td>
                </tr>
            </table>
            </p>
            <!--[if !IE]>-->
        </object>
        <!--<![endif]-->
    </object>
</noscript>
</body>
</html>
