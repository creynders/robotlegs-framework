// ActionScript file

package robotlegs.bender.extensions.commandCenter.impl{
    import flash.utils.describeType;
    
    import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;

    public function verifyCommandClass( commandClass : Class ) : void{
        if (describeType(commandClass).factory.method.(@name == "execute").length() == 0)
            throw new Error("Command Class must expose an execute method");
    }
}