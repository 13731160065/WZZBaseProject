function wzz_checkPlatform() {
    var platform = '';
    var u = navigator.userAgent;
    var isAndroid = u.indexOf('Android') > -1 || u.indexOf('Adr') > -1; //android终端
    var isiOS = !!u.match('Mac OS X'); //ios终端
    if (isAndroid) {
        platform = 'android'
    } 
    if (isiOS) {
        platform = 'ios'
    }
    
    return platform
}

function wzz_backClick() {
    var pf = wzz_checkPlatform();
    if (pf == 'ios') {
        window.webkit.messageHandlers.wzz_backClick.postMessage('');
    }
    if (pf == 'android') {

    }
}

function wzz_openUrl(url) {
    var pf = wzz_checkPlatform();
    if (pf == 'ios') {
        window.webkit.messageHandlers.wzz_openUrl.postMessage(url);
    }
    if (pf == 'android') {

    }
}

function wzz_log(logStr) {
    var pf = wzz_checkPlatform();
    if (pf == 'ios') {
        window.webkit.messageHandlers.wzz_log.postMessage(logStr);
    }
    if (pf == 'android') {

    }
}

function wzz_webToNative(funcName, autoId, params) {
    if (funcName != null) {
        if (autoId != null) {
            funcName += '@'+autoId
        } 
        params['wzz_funcName'] = funcName
    }
    var pf = wzz_checkPlatform();
    if (pf == 'ios') {
        window.webkit.messageHandlers.wzz_webToNative.postMessage(params);
    }
    if (pf == 'android') {

    }
}

function wzzvc_pushWeb(params) {
    wzz_webToNative('wzzvc_pushWeb', null, params);
}

function wzzvc_presentWeb(params) {
    wzz_webToNative('wzzvc_pushWeb', null, params);
}

function wzzvc_callBack(params) {
    wzz_webToNative('wzzvc_callBack', null, params);
}

function wzzvc_getParams() {
    wzz_webToNative('wzzvc_getParams', null, {});
}

function wzzvc_callBackFunc(params) {
    wzz_log('未实现回调方法wzzvc_callBackFunc');
}
