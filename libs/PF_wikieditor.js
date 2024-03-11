// create ext if it does not exist yet
/*global wgWikiEditorEnabledModules*/
if ( window.ext === null || typeof( window.ext ) === "undefined" ) {
	window.ext = {};
}

( function ( $, mw ) {

window.ext.wikieditor = {
	// initialize the wikieditor on the specified element
	init : function init ( inputId, params ) {
		$( function() {
			if ( mw ) {
				var $input = $( '#' + inputId );

				$.when(mw.loader.using('ext.wikiEditor'), $.ready).then(function () {
					if (typeof (mw.addWikiEditor) == 'function') {
						mw.loader.using(['ext.wikiEditor'], function () {
							mw.addWikiEditor($input);
						});
						return;
					}
				});
			}
		} );
	}
};
}( jQuery, mediaWiki ) );
