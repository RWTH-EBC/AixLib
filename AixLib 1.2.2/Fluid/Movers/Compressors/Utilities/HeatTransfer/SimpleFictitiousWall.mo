within AixLib.Fluid.Movers.Compressors.Utilities.HeatTransfer;
model SimpleFictitiousWall
  "Model of a simple fictitious wall to compute compressor's heat losses"

  // Definition of parameters describing the fictitious wall
  //
  parameter Modelica.Units.SI.Mass mWal=2.5 "Mass of the fictitious wall"
    annotation (Dialog(tab="General", group="General"));
  parameter Modelica.Units.SI.SpecificHeatCapacity cpWal=450
    "Specific heat capacity of the fictitious wall"
    annotation (Dialog(tab="General", group="General"));
  parameter Modelica.Units.SI.ThermalConductance kAMeaAmb=10 "Effective mean thermal conductance coefficient between fictitious wall 
    and ambient" annotation (Dialog(tab="General", group="General"));

  // Definition of parameters describing advanced options
  //
  parameter Boolean iniTWal0 = true
    "= true, if wall is initialised at fixed temperature; Otherwise, steady state
    initialisation"
    annotation (Dialog(tab="Advanced",group="Initialisation"));
  parameter Modelica.Units.SI.Temperature TWal0=343.15
    "Temperature of wall at initialisation"
    annotation (Dialog(tab="Advanced", group="Initialisation"));

  // Definition of submodels and connectors
  //
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heaPorComInl
    "Heart port for compressor's inlet"
    annotation (Placement(transformation(extent={{-50,10},{-30,30}}),
                iconTransformation(extent={{-56,14},{-44,26}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heaPorCom
    "Heart port for compresso's engine (compression chamber)"
    annotation (Placement(transformation(extent={{-10,10},{10,30}}),
                iconTransformation(extent={{-6,14},{6,26}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heaPorComOut
    "Heart port for compressor's outlet"
    annotation (Placement(transformation(extent={{30,10},{50,30}}),
                iconTransformation(extent={{44,14},{56,26}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heaPorAmb
    "Heart port for ambient"
     annotation (Placement(transformation(extent={{-10,-32},{10,-12}}),
                 iconTransformation(extent={{-6,-26},{6,-14}})));

  // Definition of parameters
  //
  Modelica.Units.SI.Temperature TWal "Temperature of fictitious wall";

protected
  Modelica.Units.SI.Power Q_flow_amb
    "Heat flow between ambient and fictitious wall";

initial equation
  if iniTWal0 then
    TWal=TWal0;
  else
    der(TWal)=0;
  end if;

equation
  // Calculation of energy balance
  //
  mWal*cpWal*der(TWal) = heaPorComInl.Q_flow + heaPorCom.Q_flow +
    heaPorComOut.Q_flow - Q_flow_amb
    "Energy balance of fictitious wall";
  heaPorComInl.T = TWal "Connect temperature with heat port";
  heaPorCom.T = heaPorAmb.T "Connect temperature with heat port";
  heaPorComOut.T = TWal "Connect temperature with heat port";

  // Calculation of heat flow between ambient and fictious wall
  //
  Q_flow_amb =kAMeaAmb*(TWal - heaPorAmb.T) "Calculation of heat flow";
  heaPorAmb.Q_flow = -Q_flow_amb "Connect heat flow with heat port";

  /*It is assumed that the heat flow flows out of the system*/

  annotation (Documentation(revisions="<html><ul>
  <li>October 28, 2017, by Mirko Engelpracht:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This is a model of a fictitious wall that describes the shell of the
  compressor. It consists of four heat ports, i.e. for the inlet and
  outlet of the compressor as well as for the ambient and compression
  chamber. It is assumed that the wall consists of a time invariante
  heat capacity; additionally, it is assumed that the thermal
  conductance for the calculation of the heat flow between ambient and
  fictitious wall is also time invariante.
</p>
</html>"), Icon(graphics={Rectangle(
          extent={{-80,20},{80,-20}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5), Text(
          extent={{-70,30},{70,-30}},
          lineColor={0,0,0},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="Fictitious Wall")}),
    Diagram(graphics={Rectangle(
          extent={{-70,20},{70,-22}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Forward)}));
end SimpleFictitiousWall;
