//
// A simple IoT CCN network. 
//
// @author : Asanga Udugama (adu@comnets.uni-bremen.de)
// @date   : 18-feb-2023
//
//

package inbaversim.simulations;

import inbaversim.AccessRouter;
import inbaversim.CCNInternet;
import inbaversim.ContentServer;
import inbaversim.CoreRouter;
import inbaversim.Demiurge;
import inbaversim.WiredNode;
import inbaversim.WirelessAccessRouter;
import inbaversim.WirelessNode;
import inbaversim.IoTGateway;
import inbaversim.WirelessSensorNode;
import ned.DatarateChannel;


network CompanyNetwork
{
    parameters:

        // statistics
        @statistic[appNetworkInterestRetransmissionCount](source=appNetworkInterestRetransmissionCount; record=last,vector);

        @statistic[fwdNetworkCacheHitRatio](source=fwdNetworkCacheHitRatio; record=min,max,count,last,vector);
        @statistic[fwdNetworkCacheMissRatio](source=fwdNetworkCacheMissRatio; record=min,max,count,last,vector);

        @display("bgb=624,407");

    submodules:

        // global objects
        demiurge: Demiurge {
            @display("p=73,32;is=m");
        }

        // Internet 
        internet: CCNInternet {
            @display("p=269,38;is=vl");
        }

        // external users
        justin: WiredNode {
            @display("p=431,39;is=s");
        }


        // main company infrastructure
        primaryRouter: CoreRouter {
            @display("p=325,179;is=s");
        }


        // sales department network
        sRouter: AccessRouter {
            @display("p=95,205;is=s");
        }
        sMainRouter: CoreRouter {
            @display("p=159,214;is=s");
        }
        sContent: ContentServer {
            @display("p=115,162;is=s");
        }
        sIoTGW: IoTGateway {
            @display("p=73,269;is=s");
        }
        sTemp: WirelessSensorNode {
            @display("p=31,293;is=s");
        }
        sHum: WirelessSensorNode {
            @display("p=72,316;is=s");
        }
        frank: WiredNode {
            @display("p=32,214;is=s");
        }
        thomas: WiredNode {
            @display("p=36,156;is=s");
        }


        // warehouse network
        whAP: WirelessAccessRouter {
            @display("p=367,313;is=s");
        }
        whMainRouter: CoreRouter {
            @display("p=269,270;is=s");
        }
        whContent: ContentServer {
            @display("p=194,293;is=s");
        }
        whRouter: AccessRouter {
            @display("p=226,330;is=s");
        }
        whIoTGW: IoTGateway {
            @display("p=297,316;is=s");
        }
        whHum: WirelessSensorNode {
            @display("p=324,375;is=s");
        }
        whTemp: WirelessSensorNode {
            @display("p=268,375;is=s");
        }
        james: WiredNode {
            @display("p=181,376;is=s");
        }
        daniel: WirelessNode {
            @display("p=375,349;is=s");
        }
        silvia: WirelessNode {
            @display("p=408,314;is=s");
        }


        // utility metering room
        uIoTGW: IoTGateway {
            @display("p=533,147;is=s");
        }
        uElec: WirelessSensorNode {
            @display("p=584,171;is=s");
        }
        uWater: WirelessSensorNode {
            @display("p=570,123;is=s");
        }


        // maintenance department network
        mMainRouter: CoreRouter {
            @display("p=495,268;is=s");
        }
        mRouter: AccessRouter {
            @display("p=555,249;is=s");
        }
        mContent: ContentServer {
            @display("p=555,314;is=s");
        }
        denis: WiredNode {
            @display("p=603,291;is=s");
        }




    connections allowunconnected:

        // external users
        justin.wiredInOut++ <--> DatarateChannel {  datarate = 100Mbps; } <--> internet.wiredInOut++;


        // main company infrastructure
        primaryRouter.wiredInOut++ <--> DatarateChannel {  datarate = 1Gbps;@display("ls=red,4"); } <--> internet.wiredInOut++;


        // sales department network
        frank.wiredInOut++ <--> DatarateChannel {  datarate = 100Mbps; } <--> sRouter.wiredInOut++;
        sRouter.wiredInOut++ <--> DatarateChannel {  datarate = 100Mbps; } <--> sMainRouter.wiredInOut++;
        sMainRouter.wiredInOut++ <--> DatarateChannel {  datarate = 1Gbps; } <--> sContent.wiredInOut++;
        sIoTGW.wiredInOut++ <--> DatarateChannel {  datarate = 100Mbps; } <--> sRouter.wiredInOut++;
        sMainRouter.wiredInOut++ <--> DatarateChannel {  datarate = 1Gbps;@display("ls=black,3"); } <--> primaryRouter.wiredInOut++;
        sRouter.wiredInOut++ <--> DatarateChannel {  datarate = 100Mbps; } <--> thomas.wiredInOut++;


        // warehouse network
        whMainRouter.wiredInOut++ <--> DatarateChannel {  datarate = 1Gbps;@display("ls=black,3"); } <--> primaryRouter.wiredInOut++;
        whIoTGW.wiredInOut++ <--> DatarateChannel {  datarate = 100Mbps; } <--> whMainRouter.wiredInOut++;
        whMainRouter.wiredInOut++ <--> DatarateChannel {  datarate = 1e6bps; } <--> whContent.wiredInOut++;
        whAP.wiredInOut++ <--> DatarateChannel {  datarate = 100Mbps; } <--> whMainRouter.wiredInOut++;
        whRouter.wiredInOut++ <--> DatarateChannel {  datarate = 100Mbps; } <--> whMainRouter.wiredInOut++;
        james.wiredInOut++ <--> DatarateChannel {  datarate = 100Mbps; } <--> whRouter.wiredInOut++;


        // utility metering room
        primaryRouter.wiredInOut++ <--> DatarateChannel {  datarate = 1Gbps;@display("ls=black,3"); } <--> uIoTGW.wiredInOut++;


        // maintenance department network
        mMainRouter.wiredInOut++ <--> DatarateChannel {  datarate = 100Mbps; } <--> mRouter.wiredInOut++;
        mRouter.wiredInOut++ <--> DatarateChannel {  datarate = 100Mbps; } <--> denis.wiredInOut++;
        primaryRouter.wiredInOut++ <--> DatarateChannel {  datarate = 1Gbps;@display("ls=black,3"); } <--> mMainRouter.wiredInOut++;
        mContent.wiredInOut++ <--> DatarateChannel {  datarate = 1Gbps; } <--> mMainRouter.wiredInOut++;
}
