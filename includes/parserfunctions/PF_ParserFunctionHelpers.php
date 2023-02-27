<?php

class PFParserFunctionHelpers {

	/**
     * Handle the free parameter case for the forminput and formlink parser functions
     */
    public static function handleFreeParameter( $paramName, $value, &$inQueryArr, &$hasReturnTo ) : void {
		if ( strpos( $value, ":" ) !== false ) {
			$parts = explode( ":", $value );
			$parts[0] = str_replace( " ", "_", $parts[0] );
			$value = implode( ":", $parts );
		}
		$value = html_entity_decode($value);
		$value = urlencode( $value );
		parse_str( "$paramName=$value", $arr );
		$inQueryArr = PFUtils::arrayMergeRecursiveDistinct( $inQueryArr, $arr );
		if ( $paramName == 'returnto' ) {
			$hasReturnTo = true;
		}
	}
}
