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
        window.androiddyy.wzz_backClick();
    }
}

function wzz_openUrl(url) {
    var pf = wzz_checkPlatform();
    if (pf == 'ios') {
        window.webkit.messageHandlers.wzz_openUrl.postMessage(url);
    }
    if (pf == 'android') {
        window.androiddyy.wzz_openUrl(url)
    }
}

function wzz_log(logStr) {
    var pf = wzz_checkPlatform();
    if (pf == 'ios') {
        window.webkit.messageHandlers.wzz_log.postMessage(logStr);
    }
    if (pf == 'android') {
        window.androiddyy.wzz_openUrl(logStr)
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
        window.androiddyy.wzz_webToNative(params)
    }
}

function wzzvc_pushWeb(params) {
    var pf = wzz_checkPlatform();
    if (pf == 'ios') {
        wzz_webToNative('wzzvc_pushWeb', null, params);
    } else {
        window.androiddyy.wzzvc_pushWeb(params)
    }
}

function wzzvc_presentWeb(params) {
    var pf = wzz_checkPlatform();
    if (pf == 'ios') {
        wzz_webToNative('wzzvc_presentWeb', null, params);
    } else {
        window.androiddyy.wzzvc_presentWeb(params)
    }
}

function wzzvc_pushVC(params) {
    var pf = wzz_checkPlatform();
    if (pf == 'ios') {
        wzz_webToNative('wzzvc_pushVC', null, params);
    } else {
        window.androiddyy.wzzvc_pushVC(params)
    }
}

function wzzvc_callBack(params) {
    var pf = wzz_checkPlatform();
    if (pf == 'ios') {
        wzz_webToNative('wzzvc_callBack', null, params);
    } else {
        window.androiddyy.wzzvc_callBack(params)
    }
}

function wzzvc_getParams() {
    var pf = wzz_checkPlatform();
    if (pf == 'ios') {
        wzz_webToNative('wzzvc_getParams', null, {});
    } else {
        window.androiddyy.wzzvc_getParams()
    }
}

function wzzvc_callBackFunc(params) {
    wzz_log('未实现回调方法wzzvc_callBackFunc');
}
