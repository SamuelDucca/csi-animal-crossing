import inet.common.scenario.ScenarioManager;
import inet.physicallayer.unitdisk.UnitDiskRadioMedium;
import inet.physicallayer.contract.packetlevel.IRadioMedium;
import inet.visualizer.contract.IIntegratedVisualizer;
import rpl.RplRouter;
import inet.networklayer.configurator.ipv6.Ipv6FlatNetworkConfigurator;


import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.node.inet.AdhocHost;
import inet.node.wireless.Probe;
import inet.physicallayer.common.packetlevel.RadioMedium;
import inet.visualizer.integrated.IntegratedCanvasVisualizer;

network RplNetwork
{
    parameters:
        int numNodes;
        int numSinks = default(1);
        @display("bgb=450,650");
        
    //@statistic[bitErrorRate](title="Bit error rate"; source=bitErrorRate(packetSentToUpper); record=vector);
    //@statistic[packetErrorRate](title="Packet error rate"; source=packetErrorRate(packetSentToUpper); record=vector);
    submodules:
        visualizer: <default("IntegratedCanvasVisualizer")> like IIntegratedVisualizer if hasVisualizer() {
            @display("p=550,50");
            networkRouteVisualizer.displayRoutes = true;
        }
        radioMedium: RadioMedium {
            @display("p=550,250;is=s");
        }
        configurator: Ipv6FlatNetworkConfigurator {
            @display("p=550,150;is=s");
        }
        rplSink[numSinks]: RplRouter {
            @display("i=misc/sensor2");
        }
        rplHost[numNodes]: RplRouter {
            @display("i=misc/sensor2");
        }
        wifiHost[numNodes]: AdhocHost {
            @display("p=40.791748,11.9189995;i=device/laptop");
        }
        wifiSink[numNodes]: AdhocHost {
            @display("p=40.791748,31.4415;i=device/laptop");
        }

    connections allowunconnected:
        rplHost[0].ethg++ <--> {  delay = 0.5us; datarate = 100Mbps; } <--> rplSink[0].ethg++;

}