within AixLib.Fluid;
package Solar
  package Electric
    extends Modelica.Icons.Package;

    model PVsystem "PVSystem"


       parameter Integer NumberOfPanels = 1 "number of Panels %NumberOfPanels";
      parameter AixLib.DataBase.SolarElectric.PV_data data=
          AixLib.DataBase.SolarElectric.SE6M181_14_panels()
        annotation (choicesAllMatching=true);

      parameter Modelica.SIunits.Power max_Output_Power
        " Maximum Output Power for Inverter in W";

     BaseClases.PVmoduleDC pVmoduleDC1(
        eta0=data.eta0,
        NOCT_Temp=data.NOCT_Temp,
        NOCT_Temp_Cell=data.NOCT_Temp_Cell,
        NOCT_radiation=data.NOCT_radiation,
        TempCoeff=data.Temp_coeff,
        Area=NumberOfPanels*data.Area)
        annotation (Placement(transformation(extent={{-15,60},{5,80}})));
       Modelica.Blocks.Interfaces.RealOutput PV_Power_W
         annotation (Placement(transformation(extent={{80,0},{100,20}})));
       Modelica.Blocks.Interfaces.RealInput Temp_outside "in C"
         annotation (Placement(transformation(extent={{-126,50},{-86,90}})));
      BaseClases.PVinverterRMS pVinverterRMS(uMax2=max_Output_Power)
        annotation (Placement(transformation(extent={{44,0},{64,20}})));
      AixLib.Utilities.Interfaces.SolarRad_in ic_total_rad
        annotation (Placement(transformation(extent={{-122,-20},{-98,6}})));
       Modelica.Blocks.Math.UnitConversions.To_degC to_degC
         annotation (Placement(transformation(extent={{-70,62},{-50,82}})));
    equation
      connect(pVmoduleDC1.DC_output_power, pVinverterRMS.DC_power_input)
        annotation (Line(
          points={{5,70},{22,70},{22,66},{36,66},{36,10.2},{43.8,10.2}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(pVinverterRMS.PV_Power_RMS_W, PV_Power_W) annotation (Line(
          points={{64,10},{90,10}},
          color={0,0,127},
          smooth=Smooth.None));

       pVmoduleDC1.Solar_Irradation_per_m2 =  ic_total_rad.I;

       connect(Temp_outside, to_degC.u) annotation (Line(
           points={{-106,70},{-90,70},{-90,72},{-72,72}},
           color={0,0,127},
           smooth=Smooth.None));
       connect(pVmoduleDC1.ambient_temperature_in_C, to_degC.y) annotation (Line(
           points={{-15.2,65.2},{-31.6,65.2},{-31.6,72},{-49,72}},
           color={0,0,127},
           smooth=Smooth.None));
      annotation (
       pVinverterRMS1(_base(t(flags=8194))),
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
       experiment(
           StopTime=3.1536e+007,
           NumberOfIntervals=300,
           Algorithm="Lsodar"),
         Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                 {100,100}}),
                 graphics),
         __Dymola_experimentSetupOutput,
         Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>PV model is based on manufactory data and performance factor including the NOCT.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://HVAC/Images/stars3.png\"/></p>
<p><br><b><font style=\"color: #008000; \">Assumptions</font></b></p>
<p>PV model is based on manufactory data and performance factor.</p>
<p><img src=\"modelica://HVAC/Images/PV1.png\"/></p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>PV system (data) and literature are documented and can be found: </p>
<p>data:U:\\FG_Modelica\\Intern\\Erweiterung Modelle\\PV\\datasheets</p>
<p>equation and paper: U:\\FG_Modelica\\Intern\\Erweiterung Modelle\\PV\\equations</p>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p><a href=\"HVAC.Examples.Solar_UC.Electric.Testing_PV\">HVAC.Examples.Solar_UC.Electric.Testing_PV</a></p>
</html>",    revisions="<html>
<p><ul>
<li><i>Februar 21, 2013 </i> by Corinna Leonhardt:<br/>Implemented</li>
</ul></p>
</html>"));
    end PVsystem;

    package BaseClases
            extends Modelica.Icons.BasesPackage;

      model PVmoduleDC "PVmoduleDC with temperature dependency for efficiency"

      parameter Real Area=20;
      parameter Real eta0=0.176;
      parameter Real NOCT_Temp=25;
      parameter Real NOCT_Temp_Cell=45;
      parameter Real NOCT_radiation=1000;
      parameter Real TempCoeff=0.003;
      Real Power_PV;
      Real eta_var;
      Real T_cell;

       Modelica.Blocks.Interfaces.RealInput Solar_Irradation_per_m2
          "'input Real' as connector"                                                            annotation(Placement(
        transformation(extent={{-115,49},{-75,89}}),
        iconTransformation(extent={{-122,32},{-82,72}})));
       Modelica.Blocks.Interfaces.RealInput ambient_temperature_in_C
          "ambient temperature in Celsius"                                                           annotation(Placement(
        transformation(extent={{-115,-70},{-75,-30}}),
        iconTransformation(extent={{-122,-68},{-82,-28}})));
       Modelica.Blocks.Interfaces.RealOutput DC_output_power
          "DC output power of PV panels"                                                   annotation(Placement(
        transformation(extent={{110,70},{130,90}}),
        iconTransformation(extent={{90,-10},{110,10}})));

      equation
        T_cell=ambient_temperature_in_C+(NOCT_Temp_Cell-NOCT_Temp)*Solar_Irradation_per_m2/NOCT_radiation;
        eta_var=eta0-TempCoeff*(T_cell-NOCT_Temp)*eta0;
        Power_PV=Solar_Irradation_per_m2*Area*eta_var;
        DC_output_power=Power_PV;
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
         experiment(
          StopTime=1,
          StartTime=0),
          Diagram(graphics),
           Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>The <b>PVmoduleDC</b> model represents a simple PV cell. </p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://HVAC/Images/stars2.png\"/></p>
<p><h4><font color=\"#008000\">Concept</font></h4></p>
<p>PV moduleDC has a temperature&nbsp;dependency&nbsp;for&nbsp;efficiency.</p>
</html>",  revisions="<html>
<p><ul>
<li><i>Februar 21, 2013  </i>by Corinna Leonhardt:<br/>Implemented</li>
</ul></p>
</html>"));
      end PVmoduleDC;

      model PVinverterRMS "PVinverterRMS with reliable system manager (from ACS)"

       Modelica.Blocks.Nonlinear.Limiter max_Output_Power(
        uMax(
         quantity="Basics.Power",
         displayUnit="Nm/s")=uMax2,
        uMin=0)
               annotation(Placement(transformation(extent={{40,70},{60,90}})));
       Modelica.Blocks.Tables.CombiTable1Ds Efficiency_Converter_SunnyBoy3800(
        tableOnFile=false,
        table=[0,0.798700;100,0.848907;200,0.899131;250,0.911689;300,0.921732;350,0.929669;400,0.935906;450,0.940718;500,0.943985;550,0.946260;600,0.947839;700,0.950638;800,0.952875;900,0.954431;1000,0.955214;1250,0.956231;1500,0.956449;2000,0.955198;2500,0.952175;3000,0.948659;3500,0.944961;3800,0.942621])
                                                                                                     annotation(Placement(transformation(extent={{-25,55},{-5,75}})));
       Modelica.Blocks.Math.Product product2 annotation(Placement(transformation(extent={{10,70},{30,90}})));
      // StaticBlocksContainer _staticBlocks;
       Modelica.Blocks.Interfaces.RealOutput PV_Power_RMS_W
          "'output Real' as connector"                                                    annotation(Placement(
        transformation(extent={{85,70},{105,90}}),
        iconTransformation(
         origin={100,0},
         extent={{-10,-10},{10,10}})));
       Modelica.Blocks.Interfaces.RealInput DC_power_input
          "'input Real' as connector"                                                   annotation(Placement(
        transformation(extent={{-80,55},{-40,95}}),
        iconTransformation(extent={{-122,-18},{-82,22}})));
       parameter Real uMax2(
        quantity="Basics.Power",
        displayUnit="kW")=4000 "Upper limits of input signals (max_Output_Power)";
      equation
        connect(product2.u2,Efficiency_Converter_SunnyBoy3800.y[1]) annotation(Line(
         points={{8,74},{3,74},{1,74},{1,65},{-4,65}},
         color={0,0,127}));
        connect(product2.y,max_Output_Power.u) annotation(Line(
         points={{31,80},{36,80},{33,80},{38,80}},
         color={0,0,127}));
        connect(max_Output_Power.y,PV_Power_RMS_W) annotation(Line(
         points={{61,80},{65,80},{90,80},{95,80}},
         color={0,0,127}));
        connect(product2.u1,DC_power_input) annotation(Line(
         points={{8,86},{5,86},{-55,85},{-55,75},{-60,75}},
         color={0,0,127}));
        connect(Efficiency_Converter_SunnyBoy3800.u,DC_power_input) annotation(Line(
         points={{-27,65},{-30,65},{-55,65},{-55,75},{-60,75}},
         color={0,0,127}));
        annotation (
         viewinfo[1](
          minOrder=0.5,
          maxOrder=12,
          mode=0,
          minStep=0.01,
          maxStep=0.1,
          relTol=1e-005,
          oversampling=4,
          anaAlgorithm=0,
          typename="AnaStatInfo"),
         Efficiency_Converter_SunnyBoy3800(
          tableName(flags=128),
          fileName(flags=128)),
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
           Diagram(graphics),
           Documentation(revisions="<html>
<p><ul>
<li><i>Februar 21, 2013  </i>by Corinna Leonhardt:<br/>Implemented</li>
</ul></p>
</html>",  info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>The<b> PVinverterRMS</b> model represents a simple PV inverter. </p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://HVAC/Images/stars2.png\"/></p>
<p><h4><font color=\"#008000\">Concept</font></h4></p>
<p>PVinverterRMS&nbsp;with&nbsp;reliable&nbsp;system&nbsp;manager&nbsp;(from&nbsp;ACS).</p>
</html>"));
      end PVinverterRMS;
    end BaseClases;

    package Examples
      extends Modelica.Icons.ExamplesPackage;

      model Testing_PV

        extends Modelica.Icons.Example;

        PVsystem                                pVsystem(
          max_Output_Power=4000,
          NumberOfPanels=5,
          data=DataBase.SolarElectric.SE6M181_14_panels())  "cle"
          annotation (Placement(transformation(extent={{-22,38},{-2,58}})));
        Modelica.Blocks.Interfaces.RealOutput Power
          annotation (Placement(transformation(extent={{52,40},{72,60}})));
      public
        AixLib.Building.Components.Weather.Weather Weather(
          Latitude=49.5,
          Longitude=8.5,
          GroundReflection=0.2,
          tableName="wetter",
          extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
          Wind_dir=false,
          Air_temp=true,
          Wind_speed=false,
          SOD=AixLib.DataBase.Weather.SurfaceOrientation.SurfaceOrientationData_N_E_S_W_RoofN_Roof_S(),
          fileName="D:/GIT/AixLib/AixLib/Resources/WeatherData/TRY2010_12_Jahr_Modelica-Library.txt")
          annotation (Placement(transformation(extent={{-93,49},{-68,66}})));

      equation
        connect(pVsystem.PV_Power_W, Power)     annotation (Line(
            points={{-3,49},{-3.5,49},{-3.5,50},{62,50}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(Weather.SolarRadiation_OrientedSurfaces[6], pVsystem.ic_total_rad)
          annotation (Line(
            points={{-87,48.15},{-87,47.3},{-23,47.3}},
            color={255,128,0},
            smooth=Smooth.None));
        connect(Weather.AirTemp, pVsystem.Temp_outside) annotation (Line(
            points={{-67.1667,60.05},{-56,60.05},{-56,55},{-22.6,55}},
            color={0,0,127},
            smooth=Smooth.None));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                  -100,-100},{100,100}}),
                            graphics),
          experiment(
            StopTime=3.1536e+007,
            Interval=3600,
            __Dymola_Algorithm="Lsodar"),
          __Dymola_experimentSetupOutput,
          Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Simulation to test the <a href=\"HVAC.Components.Solar_UC.Electric.PVsystem\">PVsystem</a> model. The path of the weather matrix file TRY2010_12_Jahr_Modelica-Library.txt needs to be adjusted.</p>
</html>",   revisions="<html>
<p><ul>
<li><i>April 16, 2014 &nbsp;</i> by Ana Constantin:<br/>Formated documentation.</li>
</ul></p>
</html>"));
      end Testing_PV;
    end Examples;
  end Electric;
end Solar;
