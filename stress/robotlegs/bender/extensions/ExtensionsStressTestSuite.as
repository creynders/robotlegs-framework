package robotlegs.bender.extensions
{
    import robotlegs.bender.extensions.eventCommandMap.EventCommandMapExtensionTest;
    import robotlegs.bender.extensions.eventCommandMap.impl.EventCommandExecutorStressTest;

    /**
     * @author creynder
     */
    [RunWith("org.flexunit.runners.Suite")]
    [Suite]
    public class ExtensionsStressTestSuite{
        public function ExtensionsStressTestSuite()
        {
        }
        
        public var eventCommandExecutor : EventCommandExecutorStressTest;
    }
}