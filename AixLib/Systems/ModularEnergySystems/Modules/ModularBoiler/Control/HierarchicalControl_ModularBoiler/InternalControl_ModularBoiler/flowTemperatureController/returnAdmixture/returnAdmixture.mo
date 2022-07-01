within AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler.Control.HierarchicalControl_ModularBoiler.InternalControl_ModularBoiler.flowTemperatureController.returnAdmixture;
model returnAdmixture
  "Flow temperature control with return admixture"
  parameter Integer k=1 "Number of heat curcuits";
  parameter Boolean variableSetTemperature_admix=false "Choice between variable oder constant boiler temperature for the admixture control";

  parameter Modelica.SIunits.Temperature TBoiler= 273.15+75 "Fix boiler temperature for the admixture";
  parameter Real k_ControlAdmix(min=Modelica.Constants.small)=0.005 "Gain of controller";
  parameter Modelica.SIunits.Time Ti_ControlAdmix(min=Modelica.Constants.small)=10 "Time constant of Integrator block";

  Modelica.Blocks.Interfaces.RealOutput valPos[k]
    "Valve position for the k heat curcuits"
    annotation (Placement(transformation(extent={{90,-68},{110,-48}})));
  Modelica.Blocks.Interfaces.RealInput TMea[k]
    "Measurement temperatures for the k heat curcuits" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-100})));
  Modelica.Blocks.Continuous.LimPID PID[k](
    each controllerType=Modelica.Blocks.Types.SimpleController.PI,
    each k=k_ControlAdmix,
    each Ti=Ti_ControlAdmix,
    each yMax=0.95,
    each yMin=0.05)
                 annotation (Placement(transformation(extent={{-10,-68},{10,-48}})));
  Modelica.Blocks.Interfaces.RealOutput PLRset
    annotation (Placement(transformation(extent={{90,36},{110,56}})));
  Modelica.Blocks.Interfaces.BooleanInput isOn
    annotation (Placement(transformation(extent={{-120,54},{-80,94}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{34,64},{54,84}})));
  Modelica.Blocks.Sources.RealExpression realExpression
    annotation (Placement(transformation(extent={{-16,58},{6,74}})));
  Modelica.Blocks.Interfaces.RealInput TMeaBoiler
    "Measured boiler temperature to keep the fixed temperature"
    annotation (Placement(transformation(extent={{-122,-20},{-82,20}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=TBoiler) if not variableSetTemperature_admix
    annotation (Placement(transformation(extent={{-66,12},{-46,32}})));
  Modelica.Blocks.Continuous.LimPID PID1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    Ti=2,
    yMax=0.999,
    yMin=0) "PI Controller for controlling the valve position"
            annotation (Placement(transformation(extent={{-10,12},{10,32}})));
  Modelica.Blocks.Interfaces.RealInput TCon[k]
    "Set temperature for the consumers"
    annotation (Placement(transformation(extent={{-120,-78},{-80,-38}})));

    Boolean isOnMea;
  Modelica.Blocks.Interfaces.RealInput TBoilerVar if variableSetTemperature_admix
    "Variable boiler temperature for the renturn admixture"
    annotation (Placement(transformation(extent={{-120,22},{-80,62}})));
equation

  /// Set temperature of the consumers
 // for m in 1:k loop
 // TConsumer[m]= Tset[m];
 // end for;

 if PLRset >0 then
    isOnMea=true;
  else
     isOnMea=false;
  end if;

  connect(isOn, switch1.u2) annotation (Line(points={{-100,74},{32,74}},
                     color={255,0,255}));
  connect(switch1.y, PLRset) annotation (Line(points={{55,74},{72,74},{72,46},{
          100,46}}, color={0,0,127}));
  connect(realExpression.y, switch1.u3) annotation (Line(points={{7.1,66},{32,
          66}},             color={0,0,127}));
  connect(realExpression1.y, PID1.u_s) annotation (Line(points={{-45,22},{-12,22}},
                                  color={0,0,127}));
  connect(TMeaBoiler, PID1.u_m) annotation (Line(points={{-102,0},{0,0},{0,10}},
                                    color={0,0,127}));
  connect(PID1.y, switch1.u1) annotation (Line(points={{11,22},{22,22},{22,82},{32,82}},
                   color={0,0,127}));
  connect(TMea, PID.u_m)
    annotation (Line(points={{0,-100},{0,-70}}, color={0,0,127}));
  connect(TCon, PID.u_s)
    annotation (Line(points={{-100,-58},{-12,-58}}, color={0,0,127}));
  connect(TBoilerVar, PID1.u_s)
    annotation (Line(points={{-100,42},{-20,42},{-20,22},{-12,22}},
                                                           color={0,0,127}));
  connect(PID.y, valPos)
    annotation (Line(points={{11,-58},{100,-58}}, color={0,0,127}));
 annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
       coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Admixture control for heat generators. The temperature control can be switched on and off via the isOn input from the outside. This model controls two seperate control loops:</p>
<ul>
<li>Flow temperature control of the boiler: The fix flow temperature of the boiler is controller by a PI-Controller which sets the PLR depending on the temperature difference between set temperature and actual temperature.</li>
<li>Flow temperature to the consument: Fix or variable flow temperature to the consument. The valve for the admixture is controlled by a PI-Controller regarding to the temperature difference between set temperature and actual temperature.</li>
</ul>
<h4>Important parameters</h4>
<ul>
<li>TBoiler: The user sets the fix flow temperature of the boiler before the simulation.</li>
</ul>
</html>"));
end returnAdmixture;
