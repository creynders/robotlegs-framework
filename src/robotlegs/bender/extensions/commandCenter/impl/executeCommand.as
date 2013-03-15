package robotlegs.bender.extensions.commandCenter.impl{
	public function executeCommand( command : Object ) : void{
		"execute" in command && command.execute();
	}
}