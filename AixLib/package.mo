within ;
package AixLib
  annotation (
  uses(
    Modelica(version="3.2.3"),
    NcDataReader2(version="2.5.0"),
    SDF(version="0.4.1"),
    Modelica_Synchronous(version="0.93.0"),
    Modelica_DeviceDrivers(version="1.8.2"),
    ModelicaServices(version="3.2.3")),
  version = "0.8.1",
  conversion(from(
    version="0.3.2", script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.3.2_to_0.4.mos",
    version="0.5.0", script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.5.0_to_0.5.1.mos",
    version="0.5.2", script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.5.2_to_0.5.3.mos",
    version="0.5.3", script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.5.3_to_0.5.4.mos",
    version="0.5.4", script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.5.4_to_0.5.5.mos",
    version="0.6.0", script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.6.0_to_0.7.0.mos",
    version="0.7.3", script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.7.3_to_0.7.4.mos",
    version="0.7.4", script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.7.4_to_0.7.5.mos",
    version="0.7.5", script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.7.5_to_0.7.6.mos",
    version="0.7.6", script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.7.6_to_0.7.7.mos",
    version="0.7.7", script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.7.7_to_0.7.8.mos",
    version="0.7.8", script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.7.8_to_0.7.9.mos",
    version="0.7.9", script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.7.9_to_0.7.10.mos",
    version="0.7.10", script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.7.10_to_0.7.11.mos",
    version="0.7.11", script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.7.11_to_0.7.12.mos",
    version="0.7.12", script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.7.12_to_0.8.0.mos",
 version="0.8.0", script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.8.0_to_0.8.1.mos"), from(
      version="0.8.1",
      to="Intermediate",
      change(
        item=convertElement(
            "AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Validation.ComparisonToAHU",
            "modularAHU.const",
            "modularAHU.cooSur"),
        item=convertElement(
            "AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.ModularAHU",
            "const",
            "cooSur"),
        item=convertElement(
            "AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Controler.ControlerHeatRecovery",
            "y",
            "hrsOn"),
        item=convertElement(
            "AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.PlateHeatExchangerFixedEfficiency",
            "u",
            "hrsOn"),
        item=convertElement(
            "AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Examples.Test_PlateHeatExchanger",
            "plateHeatExchangerFixedEfficiency.u",
            "plateHeatExchangerFixedEfficiency.hrsOn"),
        item=convertElement(
            "AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Examples.Test_PlateHeatExchanger2",
            "plateHeatExchangerFixedEfficiency.u",
            "plateHeatExchangerFixedEfficiency.hrsOn"),
        item=convertElement(
            "AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Examples.Test_ExampleAHU",
            "exampleAHU.plateHeatExchangerFixedEfficiency.u",
            "exampleAHU.plateHeatExchangerFixedEfficiency.hrsOn"),
        item=convertElement(
            "AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Examples.Test_ExampleAHU2",
            "exampleAHU_SprayHumidifier.plateHeatExchangerFixedEfficiency.u",
            "exampleAHU_SprayHumidifier.plateHeatExchangerFixedEfficiency.hrsOn"),

        item=convertElement(
            "AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Examples.Test_ExampleAHU3",
            "exampleAHU2.plateHeatExchangerFixedEfficiency.u",
            "exampleAHU2.plateHeatExchangerFixedEfficiency.hrsOn"),
        item=convertElement(
            "AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Examples.Test_ExampleAHU4",
            "exampleAHU2.plateHeatExchangerFixedEfficiency.u",
            "exampleAHU2.plateHeatExchangerFixedEfficiency.hrsOn"),
        item=convertElement(
            "AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.UnitTest.PlateHeatExchanger.Test_PlateHeatExchangerFixed",
            "plateHeatExchanger.u",
            "plateHeatExchanger.hrsOn"),
        item=convertElement(
            "AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Validation.ComparisonToAHU",
            "modularAHU.plateHeatExchangerFixedEfficiency.u",
            "modularAHU.plateHeatExchangerFixedEfficiency.hrsOn"),
        item=convertElement(
            "AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.ExampleAHU",
            "plateHeatExchangerFixedEfficiency.u",
            "plateHeatExchangerFixedEfficiency.hrsOn"),
        item=convertElement(
            "AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.ExampleAHU2",
            "plateHeatExchangerFixedEfficiency.u",
            "plateHeatExchangerFixedEfficiency.hrsOn"),
        item=convertElement(
            "AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.ExampleAHU3",
            "plateHeatExchangerFixedEfficiency.u",
            "plateHeatExchangerFixedEfficiency.hrsOn"),
        item=convertElement(
            "AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.ModularAHU",
            "plateHeatExchangerFixedEfficiency.u",
            "plateHeatExchangerFixedEfficiency.hrsOn"),
        item=convertElement(
            "AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Validation.ComparisonToAHU",
            "modularAHU.cooSur1",
            "modularAHU.watIn"),
        item=convertElement(
            "AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.ModularAHU",
            "cooSur1",
            "watIn"),
        item=convertElement(
            "AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Validation.ComparisonToAHU",
            "modularAHU.watIn",
            "modularAHU.steamIn"),
        item=convertElement(
            "AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.ModularAHU",
            "watIn",
            "steamIn"),
        item=convertElement(
            "AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Validation.ComparisonToAHU",
            "modularAHU.steamIn1",
            "modularAHU.watIn"),
        item=convertElement(
            "AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.ModularAHU",
            "steamIn1",
            "watIn"),
        item=convertElement(
            "AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Validation.ComparisonToAHU",
            "modularAHU.steamIn",
            "modularAHU.watIn"),
        item=convertElement(
            "AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.ModularAHU",
            "steamIn",
            "watIn"),
        item=convertElement(
            "AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.FanSimple",
            "T_airOut1",
            "dT_fan1"),
        item=convertElement(
            "AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Examples.Test_ExampleAHU2",
            "exampleAHU_SprayHumidifier.fanSimple.T_airOut1",
            "exampleAHU_SprayHumidifier.fanSimple.dT_fan1"),
        item=convertElement(
            "AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Examples.Test_ExampleAHU2",
            "exampleAHU_SprayHumidifier.fanSimple1.T_airOut1",
            "exampleAHU_SprayHumidifier.fanSimple1.dT_fan1"),
        item=convertElement(
            "AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Examples.Test_ExampleAHU3",
            "exampleAHU2.fanSimple.T_airOut1",
            "exampleAHU2.fanSimple.dT_fan1"),
        item=convertElement(
            "AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Examples.Test_ExampleAHU3",
            "exampleAHU2.fanSimple1.T_airOut1",
            "exampleAHU2.fanSimple1.dT_fan1"),
        item=convertElement(
            "AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Examples.Test_ExampleAHU4",
            "exampleAHU2.fanEta.T_airOut1",
            "exampleAHU2.fanEta.dT_fan1"),
        item=convertElement(
            "AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Examples.Test_ExampleAHU4",
            "exampleAHU2.fanOda.T_airOut1",
            "exampleAHU2.fanOda.dT_fan1"),
        item=convertElement(
            "AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Validation.ComparisonToAHU",
            "modularAHU.fanSimple.T_airOut1",
            "modularAHU.fanSimple.dT_fan1"),
        item=convertElement(
            "AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Validation.ComparisonToAHU",
            "modularAHU.fanSimple1.T_airOut1",
            "modularAHU.fanSimple1.dT_fan1"),
        item=convertElement(
            "AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.ExampleAHU2",
            "fanSimple.T_airOut1",
            "fanSimple.dT_fan1"),
        item=convertElement(
            "AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.ExampleAHU2",
            "fanSimple1.T_airOut1",
            "fanSimple1.dT_fan1"),
        item=convertElement(
            "AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.ExampleAHU3",
            "fanEta.T_airOut1",
            "fanEta.dT_fan1"),
        item=convertElement(
            "AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.ExampleAHU3",
            "fanOda.T_airOut1",
            "fanOda.dT_fan1"),
        item=convertElement(
            "AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.ModularAHU",
            "fanSimple.T_airOut1",
            "fanSimple.dT_fan1"),
        item=convertElement(
            "AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.ModularAHU",
            "fanSimple1.T_airOut1",
            "fanSimple1.dT_fan1")))),                                                                    Documentation(info = "<html>
    <p>The free open-source <code>AixLib</code> library is being developed for research and teaching purposes. It aims at dynamic simulations of thermal and hydraulic systems to develop control strategies for HVAC systems and analyse interactions in complex systems. It is used for simulations on component, building and city district level. As this library is developed mainly for academic purposes, user-friendliness and model robustness is not a main task. This research focus thus influences the layout and philosophy of the library. </p>
    <p>Various connectors of the Modelica Standard Library are used, e.g. <code>Modelica.Fluid</code> and <code>Modelica.HeatTransfer</code>. These are accompanied by own connectors for simplified hydraulics (no <code>fluid.media</code>, incompressible, one phase) , shortwave radiation (intensity), longwave radiation (heat flow combined with a virtual temperature) and combined longwave radiation and thermal. The pressure in the connectors is the total pressure. The used media models are simplified from the <code>Modelica.Media</code> library. If possible and necessary, components use continuously differentiable equations. In general, zero mass flow rate and reverse flow are supported.</p>
    <p>Most models have been analytically verified. In addition, hydraulic components are compared to empirical data such as performance curves. High and low order building models have been validated using a standard test suite provided by the ANSI/ASHRAE Standard 140 and VDI 6007 Guideline. The library has only been tested with Dymola.</p>
    <p>The web page for this library is <a href=\"https://www.github.com/RWTH-EBC/AixLib\">https://www.github.com/RWTH-EBC/AixLib</a>. We welcome contributions from different users to further advance this library, whether it is through collaborative model development, through model use and testing or through requirements definition or by providing feedback regarding the model applicability to solve specific problems. </p>
    </html>"),
  Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={Bitmap(extent={{-106,-100},{106,100}}, fileName = "modelica://AixLib/Resources/Images/Icon_Modelica_AixLib.png")}));
end AixLib;
