<?php

/**
 * @covers \PFFormEdit
 * @covers \PFAutoeditAPI
 *
 * @author gesinn-it-wam
 */
class PFFormEditTest extends MediaWikiIntegrationTestCase {

	public function testInvalidForm() {
		$formEdit = new PFFormEdit();

		$formEdit->execute("InvalidForm/X");

		$output = $formEdit->getOutput();

		$this->assertEquals("Create InvalidForm: X", $output->getPageTitle());
		$this->assertStringContainsString('<div class="error"><p><b>InvalidForm</b> is not a valid form.', $output->mBodytext);
	}

}
