<?php

/**
 * @covers \PFHooks
 *
 * @author gesinn-it-wam
 */
class PFHooksTest extends MediaWikiIntegrationTestCase {

	/**
	 * Set up environment
	 */
	public function setUp(): void {
		parent::setUp();
	}

	public function testRunThroughOnly() {
		PFHooks::registerExtension();
		PFHooks::initialize();
		PFHooks::registerModules( new ResourceLoader() );
		$list = [];
		PFHooks::registerNamespaces( $list );
		PFHooks::registerFunctions( new Parser() );
		$this->assertTrue( true );
	}
}
