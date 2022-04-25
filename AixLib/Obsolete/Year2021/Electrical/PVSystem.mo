within AixLib.Obsolete.Year2021.Electrical;
package PVSystem

  model PVSystem "PVSystem"
    extends
      AixLib.Obsolete.Year2021.Electrical.PVSystem.BaseClasses.PartialPVSystem;
    extends AixLib.Obsolete.BaseClasses.ObsoleteModel;

    Modelica.Blocks.Interfaces.RealInput TOutside(final quantity=
          "ThermodynamicTemperature", final unit="K") "Ambient temperature"
      annotation (Placement(transformation(extent={{-140,56},{-100,96}}),
          iconTransformation(extent={{-140,56},{-100,96}})));
    AixLib.Utilities.Interfaces.SolarRad_in IcTotalRad
      "Solar radiation in W/m2"
      annotation (Placement(transformation(extent={{-124,-12},{-100,14}}),
          iconTransformation(extent={{-136,-24},{-100,14}})));

    Modelica.Blocks.Sources.RealExpression realExpression(y=IcTotalRad.I)
      annotation (Placement(transformation(extent={{-96,-10},{-76,10}})));
  equation

    connect(TOutside, PVModuleDC.T_amb) annotation (Line(points={{-120,76},{-62,
            76},{-62,66},{-15,66}}, color={0,0,127}));
    connect(realExpression.y, PVModuleDC.SolarIrradiationPerSquareMeter)
      annotation (Line(points={{-75,0},{-48,0},{-48,54.4},{-14.6,54.4}}, color={0,
            0,127}));
    annotation (
     Icon(
      coordinateSystem(extent={{-100,-100},{100,100}}),
      graphics={
       Rectangle(
        lineColor={0,0,0},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid,
        extent={{-100,100},{100,-100}}),
       Text(
        lineColor={0,0,0},
        extent={{-96,95},{97,-97}},
             textString="PV")}),
       Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
               {100,100}})),
       Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
  PV model is based on manufactory data and performance factor
  including the NOC
</p>
<p>
  <br/>
  <b><span style=\"color: #008000;\">Assumptions</span></b>
</p>
<p>
  PV model is based on manufactory data and performance factor.
</p>
<h4>
  <span style=\"color: #008000\">References</span>
</h4>
<p>
  PV system data (DataBase Records) can be found:
</p>
<ul>
  <li>
    <a href=\"http://www.eks-solar.de/pdfs/aleo_s24.pdf\">eks-solar</a>
  </li>
  <li>
    <a href=
    \"https://www.solarelectricsupply.com/canadian-solar-cs6p-250-solar-panels-117\">
    solar-electric</a>
  </li>
  <li>
    <a href=
    \"http://www.fl200.com/gourdinne/energie/Datenblatt_Kid_SME_1_Serie_DE.pdf\">
    schueco</a>
  </li>
  <li>
    <a href=
    \"https://solarco.en.ec21.com/Solar_Module_SE6M60-Series--7320291_7320754.html\">
    solarco</a>
  </li>
</ul>
<p>
  <br/>
  Source of literature for the calculation of the pv cell efficiency:
</p>
<p>
  <q>Thermal modelling to analyze the effect of cell temperature on PV
  modules energy efficiency</q> by Romary, Florian et al.
</p>
<h4>
  <span style=\"color: #008000\">Example Results</span>
</h4>
<p>
  <a href=
  \"AixLib.Fluid.Solar.Electric.Examples.ExamplePV\">AixLib.Fluid.Solar.Electric.Examples.ExamplePV</a>
</p>
</html>",  revisions="
<html><ul>
  <li>
    <i>October 20, 2017</i> ,by Larissa Kuehn:<br/>
    Implementation of PartialPVSystem.
  </li>
  <li>
    <i>October 11, 2016</i> ,by Tobias Blacha:<br/>
    Moved into AixLib
  </li>
  <li>
    <i>Februar 21, 2013</i> ,by Corinna Leonhardt:<br/>
    Implemented
  </li>
</ul>
</html>

"));
  end PVSystem;

  model PVSystemTMY3
    extends
      AixLib.Obsolete.Year2021.Electrical.PVSystem.BaseClasses.PartialPVSystem;
    extends AixLib.Obsolete.BaseClasses.ObsoleteModel;

    parameter Modelica.Units.SI.Angle Latitude=0.65798912800186
      "Location's Latitude" annotation (Dialog(group="Location"));

    parameter Modelica.Units.SI.Angle til=0.34906585039887
      "Surface's tilt angle (0:flat)" annotation (Dialog(group="Geometry"));

    parameter Modelica.Units.SI.Angle azi=-0.78539816339745
      "Surface's azimut angle (0:South)" annotation (Dialog(group="Geometry"));

    AixLib.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
          transformation(extent={{-120,-20},{-80,20}}),iconTransformation(extent={{-110,
              -10},{-90,10}})));
    Modelica.Blocks.Math.Add G "Total irradiation on tilted surface"
      annotation (Placement(transformation(extent={{-28,12},{-8,32}})));
    AixLib.BoundaryConditions.SolarIrradiation.DiffusePerez    HDifTil(
      til=til,
      lat=Latitude,
      azi=azi)               "Diffuse irradiation on tilted surface"
      annotation (Placement(transformation(extent={{-62,18},{-42,38}})));
    AixLib.BoundaryConditions.SolarIrradiation.DirectTiltedSurface    HDirTil(
      til=til,
      lat=Latitude,
      azi=azi)               "Direct irradiation on tilted surface"
      annotation (Placement(transformation(extent={{-62,-10},{-42,10}})));
  equation

    connect(weaBus, HDifTil.weaBus) annotation (Line(
        points={{-100,0},{-70,0},{-70,28},{-62,28}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}}));
    connect(weaBus, HDirTil.weaBus) annotation (Line(
        points={{-100,0},{-70,0},{-62,0}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}}));
    connect(HDifTil.H, G.u1) annotation (Line(points={{-41,28},{-34,28},{-30,28}},
                      color={0,0,127}));
    connect(HDirTil.H, G.u2) annotation (Line(points={{-41,0},{-36,0},{-36,16},
            {-30,16}},
                  color={0,0,127}));
    connect(PVModuleDC.T_amb, weaBus.TDryBul) annotation (Line(points={{-15,66},{
            -88,66},{-88,4},{-88,0},{-100,0}}, color={0,0,127}));
    connect(G.y, PVModuleDC.SolarIrradiationPerSquareMeter) annotation (Line(
          points={{-7,22},{-4,22},{-4,48},{-24,48},{-24,54.4},{-14.6,54.4}},
          color={0,0,127}));
   annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
       Rectangle(
        lineColor={0,0,0},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid,
        extent={{-100,100},{100,-100}}),
       Text(
        lineColor={0,0,0},
        extent={{-96,95},{97,-97}},
             textString="PV")}),                                   Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
  PV model is based on manufactory data and performance factor
  including the NOC
</p>
<p>
  <br/>
  <b><span style=\"color: #008000;\">Assumptions</span></b>
</p>
<p>
  PV model is based on manufactory data and performance factor.
</p>
<h4>
  <span style=\"color: #008000\">References</span>
</h4>
<p>
  PV system data (DataBase Records) can be found:
</p>
<ul>
  <li>
    <a href=\"http://www.eks-solar.de/pdfs/aleo_s24.pdf\">eks-solar</a>
  </li>
  <li>
    <a href=
    \"https://www.solarelectricsupply.com/canadian-solar-cs6p-250-solar-panels-117\">
    solar-electric</a>
  </li>
  <li>
    <a href=
    \"http://www.fl200.com/gourdinne/energie/Datenblatt_Kid_SME_1_Serie_DE.pdf\">
    schueco</a>
  </li>
  <li>
    <a href=
    \"https://solarco.en.ec21.com/Solar_Module_SE6M60-Series--7320291_7320754.html\">
    solarco</a>
  </li>
</ul>
<p>
  <br/>
  Source of literature for the calculation of the pv cell efficiency:
</p>
<p>
  <q>Thermal modelling to analyze the effect of cell temperature on PV
  modules energy efficiency</q> by Romary, Florian et al.
</p>
<h4>
  <span style=\"color: #008000\">Example Results</span>
</h4>
<p>
  <a href=
  \"AixLib.Fluid.Solar.Electric.Examples.ExamplePV_TMY3\">AixLib.Fluid.Solar.Electric.Examples.ExamplePV_TMY3</a>
</p>
<ul>
  <li>
    <i>October 20, 2017</i> ,by Larissa Kuehn:<br/>
    First implementation
  </li>
</ul>
</html>"));
  end PVSystemTMY3;

  package Examples
    extends Modelica.Icons.ExamplesPackage;

    model ExamplePV
      extends Modelica.Icons.Example;
      extends AixLib.Obsolete.BaseClasses.ObsoleteModel;

      Modelica.Blocks.Interfaces.RealOutput Power(
        final quantity="Power",
        final unit="W")
        "Output Power of the PV system including the inverter"
        annotation (Placement(transformation(extent={{72,30},{92,50}})));
      AixLib.BoundaryConditions.WeatherData.Old.WeatherTRY.Weather Weather(
        Latitude=49.5,
        Longitude=8.5,
        GroundReflection=0.2,
        tableName="wetter",
        extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
        Wind_dir=false,
        Air_temp=true,
        Wind_speed=false,
        SOD=AixLib.DataBase.Weather.SurfaceOrientation.SurfaceOrientationData_N_E_S_W_RoofN_Roof_S(),
        fileName=Modelica.Utilities.Files.loadResource(
            "modelica://AixLib/Resources/WeatherData/TRY2010_12_Jahr_Modelica-Library.txt"))
        "Weather data input for simulation of PV power "
        annotation (Placement(transformation(extent={{-93,49},{-68,66}})));

      PVSystem                            PVsystem(
        MaxOutputPower=4000,
        NumberOfPanels=5,
        data=AixLib.DataBase.SolarElectric.SymphonyEnergySE6M181())
        "PV system model including the inverter"
        annotation (Placement(transformation(extent={{-14,30},{6,50}})));

    equation
      connect(Weather.SolarRadiation_OrientedSurfaces[6], PVsystem.IcTotalRad)
        annotation (Line(
          points={{-87,48.15},{-87,39.5},{-15.8,39.5}},
          color={255,128,0},
          smooth=Smooth.None));
      connect(Weather.AirTemp, PVsystem.TOutside) annotation (Line(
          points={{-67.1667,60.05},{-56,60.05},{-56,47.6},{-16,47.6}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(PVsystem.PVPowerW, Power)
        annotation (Line(points={{7,40},{82,40}},         color={0,0,127}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}})),
        experiment(
          StopTime=3.1536e+007,
          Interval=3600,
          __Dymola_Algorithm="Lsodar"),
        __Dymola_experimentSetupOutput,
        Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Simulation to test the <a href=
  \"AixLib.Fluid.Solar.Electric.PVSystem\">PVsystem</a> model.
</p>
</html>", revisions="<html><ul>
<ul>
  <li>
    <i>October 11, 2016</i> by Tobias Blacha:<br/>
    Moved into AixLib
  </li>
  <li>
    <i>April 16, 2014 &#160;</i> by Ana Constantin:<br/>
    Formated documentation.
  </li>
</ul>
</html>"));
    end ExamplePV;

    model ExamplePVTMY3
      extends Modelica.Icons.Example;
      extends AixLib.Obsolete.BaseClasses.ObsoleteModel;

      Modelica.Blocks.Interfaces.RealOutput Power(
        final quantity="Power",
        final unit="W")
        "Output Power of the PV system including the inverter"
        annotation (Placement(transformation(extent={{56,30},{76,50}})));
      PVSystemTMY3                            PVsystem(
        MaxOutputPower=4000,
        NumberOfPanels=5,
        data=AixLib.DataBase.SolarElectric.SymphonyEnergySE6M181())
        "PV system model including the inverter"
        annotation (Placement(transformation(extent={{-10,30},{10,50}})));

      AixLib.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
            Modelica.Utilities.Files.loadResource("modelica://AixLib/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos"))
        annotation (Placement(transformation(extent={{-96,30},{-76,50}})));
    equation
      connect(weaDat.weaBus, PVsystem.weaBus) annotation (Line(
          points={{-76,40},{-10,40}},
          color={255,204,51},
          thickness=0.5));
      connect(PVsystem.PVPowerW, Power)
        annotation (Line(points={{11,40},{11,40},{66,40}},
                                                  color={0,0,127}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}})),
        experiment(
          StopTime=3.1536e+007,
          Interval=3600,
          __Dymola_Algorithm="Lsodar"),
        __Dymola_experimentSetupOutput,
        Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Simulation to test the <a href=
  \"AixLib.Fluid.Solar.Electric.PVSystemTMY3\">PVsystemTMY3</a> model.
</p>
</html>", revisions="<html><ul>
<ul>
  <li>
    <i>October 20, 2017</i> ,by Larissa Kuehn:<br/>
    First implementation
  </li>
</ul>
</html>"));
    end ExamplePVTMY3;
  end Examples;

  package BaseClasses
    extends Modelica.Icons.BasesPackage;

    partial model PartialPVSystem "Partial model for PV System"
      extends AixLib.Obsolete.BaseClasses.ObsoleteModel;

      parameter Integer NumberOfPanels = 1
        "Number of panels";
      parameter AixLib.Obsolete.Year2021.DataBase.SolarElectric.PVBaseRecord
        data "PV data set" annotation (choicesAllMatching=true);
      parameter Modelica.Units.SI.Power MaxOutputPower
        "Maximum output power for inverter";
      Modelica.Blocks.Interfaces.RealOutput PVPowerW(
        final quantity="Power",
        final unit="W")
        "Output Power of the PV system including the inverter"
         annotation (Placement(transformation(extent={{100,-10},{120,10}}),
            iconTransformation(extent={{100,-10},{120,10}})));

      AixLib.Obsolete.Year2021.Electrical.PVSystem.BaseClasses.PVModuleDC PVModuleDC(
        final Eta0=data.Eta0,
        final NoctTemp=data.NoctTemp,
        final NoctTempCell=data.NoctTempCell,
        final NoctRadiation=data.NoctRadiation,
        final TempCoeff=data.TempCoeff,
        final Area=NumberOfPanels*data.Area)
        "PV module with temperature dependent efficiency"
        annotation (Placement(transformation(extent={{-13,50},{7,70}})));
      AixLib.Obsolete.Year2021.Electrical.PVSystem.BaseClasses.PVInverterRMS PVInverterRMS(final
          uMax2=MaxOutputPower) "Inverter model including system management"
        annotation (Placement(transformation(extent={{40,0},{60,20}})));
    equation

      connect(PVModuleDC.DCOutputPower, PVInverterRMS.DCPowerInput) annotation (
          Line(points={{8,60},{28,60},{28,10.2},{39.8,10.2}}, color={0,0,127}));
      connect(PVInverterRMS.PVPowerRmsW, PVPowerW) annotation (Line(points={{60,10},
              {82,10},{82,0},{110,0}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
         Rectangle(
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          extent={{-100,100},{100,-100}}),
         Text(
          lineColor={0,0,0},
          extent={{-96,95},{97,-97}},
               textString="PV")}),                                   Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        Documentation(revisions="<html><ul>
  <li>
    <i>October 20, 2017</i> ,by Larissa Kuehn<br/>
    First implementation
  </li>
</ul>
</html>"));
    end PartialPVSystem;

    model PVInverterRMS "Inverter model including system management"
      extends AixLib.Obsolete.BaseClasses.ObsoleteModel;

      parameter Modelica.Units.SI.Power uMax2
        "Upper limits of input signals (MaxOutputPower)";
     Modelica.Blocks.Interfaces.RealOutput PVPowerRmsW(
      final quantity="Power",
      final unit="W")
      "Output power of the PV system including the inverter"
      annotation(Placement(
      transformation(extent={{85,70},{105,90}}),
      iconTransformation(
       origin={100,0},
       extent={{-10,-10},{10,10}})));
     Modelica.Blocks.Interfaces.RealInput DCPowerInput(
      final quantity="Power",
      final unit="W")
      "DC output power of PV panels as input for the inverter"
      annotation(Placement(
      transformation(extent={{-80,55},{-40,95}}),
      iconTransformation(extent={{-122,-18},{-82,22}})));
     Modelica.Blocks.Nonlinear.Limiter MaxOutputPower(
       uMax(
        final quantity="Power",
        final displayUnit="Nm/s")=uMax2,
       uMin=0)
       "Limitier for maximum output power"
       annotation(Placement(transformation(extent={{40,70},{60,90}})));
     Modelica.Blocks.Tables.CombiTable1Ds EfficiencyConverterSunnyBoy3800(
       tableOnFile=false,
       table=[0,0.798700;100,0.848907;200,0.899131;250,0.911689;300,0.921732;350,0.929669;400,0.935906;450,0.940718;500,0.943985;550,0.946260;600,0.947839;700,0.950638;800,0.952875;900,0.954431;1000,0.955214;1250,0.956231;1500,0.956449;2000,0.955198;2500,0.952175;3000,0.948659;3500,0.944961;3800,0.942621])
         "Efficiency of the inverter for different operating points"
         annotation(Placement(transformation(extent={{-25,55},{-5,75}})));
     Modelica.Blocks.Math.Product Product2
         "Multiplies the output power of the PV cell with the efficiency of the inverter "
         annotation(Placement(transformation(extent={{10,70},{30,90}})));

    equation
      connect(Product2.u2,EfficiencyConverterSunnyBoy3800.y[1]) annotation(Line(
       points={{8,74},{3,74},{1,74},{1,65},{-4,65}},
       color={0,0,127}));
      connect(Product2.y,MaxOutputPower.u) annotation(Line(
       points={{31,80},{36,80},{33,80},{38,80}},
       color={0,0,127}));
      connect(MaxOutputPower.y,PVPowerRmsW) annotation(Line(
       points={{61,80},{65,80},{90,80},{95,80}},
       color={0,0,127}));
      connect(Product2.u1,DCPowerInput) annotation(Line(
       points={{8,86},{5,86},{-55,86},{-55,75},{-60,75}},
       color={0,0,127}));
      connect(EfficiencyConverterSunnyBoy3800.u,DCPowerInput) annotation(Line(
       points={{-27,65},{-30,65},{-55,65},{-55,75},{-60,75}},
       color={0,0,127}));
        annotation (
       Icon(
        coordinateSystem(extent={{-100,-100},{100,100}}),
        graphics={
         Rectangle(
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          extent={{-100,100},{100,-100}}),
         Line(
          points={{-50,37},{53,37}},
          color={0,0,0}),
         Line(
          points={{-48,-34},{55,-34}},
          color={0,0,0})}),
       experiment(
        StopTime=1,
        StartTime=0),
         Documentation(revisions="<html><ul>
  <li>
    <i>October 11, 2016</i> by Tobias Blacha:<br/>
    Moved into AixLib
  </li>
  <li>
    <i>Februar 21, 2013</i> by Corinna Leonhardt:<br/>
    Implemented
  </li>
</ul>
</html>",info="<html><h4>
<span style=\"color: #008000\">Overview</span>
<p>
  The <b>PVinverterRMS</b> model represents a simple PV inverter.
</p>
<p>
  <br/>
  <b><span style=\"color: #008000;\">Concept</span></b>
</p>
<p>
  PVinverterRMS&#160;with&#160;reliable&#160;system&#160;manager.
</p>
</html>"));
    end PVInverterRMS;

    model PVModuleDC "partial model for PV module"
      extends AixLib.Obsolete.BaseClasses.ObsoleteModel;

      parameter Modelica.Units.SI.Area Area "Area of one Panel";
      parameter Modelica.Units.SI.Efficiency Eta0 "Maximum efficiency";
      parameter Modelica.Units.SI.Temperature NoctTemp "Defined temperature";
      parameter Modelica.Units.SI.Temperature NoctTempCell
        "Meassured cell temperature";
      parameter Modelica.Units.SI.RadiantEnergyFluenceRate NoctRadiation
        "Defined radiation";
      parameter Modelica.Units.SI.LinearTemperatureCoefficient TempCoeff
        "Temperature coeffient";
      Modelica.Units.SI.Power PowerPV "Power of PV panels";
      Modelica.Units.SI.Efficiency EtaVar "Efficiency of PV cell";
      Modelica.Units.SI.Temperature TCell "Cell temperature";

     Modelica.Blocks.Interfaces.RealOutput DCOutputPower(
      final quantity="Power",
      final unit="W")
      "DC output power of PV panels"
      annotation(Placement(
      transformation(extent={{100,70},{120,90}}),
      iconTransformation(extent={{100,-10},{120,10}})));
     Modelica.Blocks.Interfaces.RealInput T_amb(final quantity=
            "ThermodynamicTemperature", final unit="K") "Ambient temperature"
        annotation (Placement(transformation(extent={{-139,40},{-99,80}}),
            iconTransformation(extent={{-140,40},{-100,80}})));

      Modelica.Blocks.Interfaces.RealInput SolarIrradiationPerSquareMeter
       annotation (Placement(
            transformation(extent={{-140,-80},{-100,-40}}), iconTransformation(
              extent={{-132,-72},{-100,-40}})));

    equation
      TCell=T_amb + (NoctTempCell - NoctTemp)*SolarIrradiationPerSquareMeter/
        NoctRadiation;
      PowerPV=SolarIrradiationPerSquareMeter*Area*EtaVar;
      EtaVar=Eta0-TempCoeff*(TCell-NoctTemp)*Eta0;
      DCOutputPower=PowerPV;

      annotation (
       Icon(
        coordinateSystem(extent={{-100,-100},{100,100}}),
        graphics={
         Rectangle(
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          extent={{-100,100},{100,-100}}),
         Line(
          points={{-3,100},{100,0},{0,-100}},
          color={0,0,0})}),
         Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
  The <b>PVmoduleDC_TMY3</b> model represents a simple PV cell.
</p>
<h4>
  <span style=\"color: #008000\">Concept</span>
</h4>
<p>
  PV moduleDC has a
  temperature&#160;dependency&#160;for&#160;efficiency.
</p>
</html>",revisions="<html><ul>
<ul>
  <li>
    <i>October 20, 2017</i> by Larissa Kühn:<br/>
    Modification of Input to make the model compatible with diffent
    weather models
  </li>
  <li>
    <i>October 11, 2016</i> by Tobias Blacha:<br/>
    Moved into AixLib
  </li>
  <li>
    <i>Februar 21, 2013</i> by Corinna Leonhardt:<br/>
    Implemented
  </li>
</ul>
</html>"),     Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end PVModuleDC;
  end BaseClasses;
annotation (Icon(graphics={
        Rectangle(
          lineColor={200,200,200},
          fillColor={248,248,248},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-100.0,-100.0},{100.0,100.0}},
          radius=25.0),
        Rectangle(
          lineColor={128,128,128},
          extent={{-100.0,-100.0},{100.0,100.0}},
          radius=25.0),      Polygon(points={{-80,-80},{-40,80},{80,80},{40,-80},
              {-80,-80}}, lineColor={0,0,0}),
        Line(points={{-60,-76},{-20,76}}, color={0,0,0}),
        Line(points={{-34,-76},{6,76}}, color={0,0,0}),
        Line(points={{-8,-76},{32,76}}, color={0,0,0}),
        Line(points={{16,-76},{56,76}}, color={0,0,0}),
        Line(points={{-38,60},{68,60}}, color={0,0,0}),
        Line(points={{-44,40},{62,40}}, color={0,0,0}),
        Line(points={{-48,20},{58,20}}, color={0,0,0}),
        Line(points={{-54,0},{52,0}}, color={0,0,0}),
        Line(points={{-60,-20},{46,-20}}, color={0,0,0}),
        Line(points={{-64,-40},{42,-40}}, color={0,0,0}),
        Line(points={{-70,-60},{36,-60}}, color={0,0,0})}));
end PVSystem;
