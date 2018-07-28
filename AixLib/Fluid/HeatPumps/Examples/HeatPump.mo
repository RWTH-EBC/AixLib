within AixLib.Fluid.HeatPumps.Examples;
model HeatPump
  "Example for the detailed heat pump model in order to compare to simple one."

 extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.Ramp rampY(
    duration=2000,
    startTime=20,
    height=100,
    offset=-20) annotation (Placement(transformation(extent={{-58,-30},{-38,-10}})));
  BaseClasses.SecurityControls.BaseClasses.BoundaryMap boundaryMap(
    tableLow=[-15,0; 30,0],
    tableUpp=[-15,55; 5,60; 30,60])
    annotation (Placement(transformation(extent={{0,-16},{38,18}})));
  Modelica.Blocks.Sources.Constant
                               const(k=30)
    annotation (Placement(transformation(extent={{-58,16},{-38,36}})));
equation

  connect(const.y, boundaryMap.y_in) annotation (Line(points={{-37,26},{-20,26},{-20,
          -9.2},{-2.66,-9.2}}, color={0,0,127}));
  connect(rampY.y, boundaryMap.x_in) annotation (Line(points={{-37,-20},{-20,-20},{-20,
          11.2},{-2.66,11.2}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(StopTime=3600),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<h4><span style=\"color: #008000\">Overview</span></h4>
<p>Simple test set-up for the HeatPumpDetailed model. The heat pump is turned on and off while the source temperature increases linearly. Outputs are the electric power consumption of the heat pump and the supply temperature. </p>
<p>Besides using the default simple table data, the user should also test tabulated data from <a href=\"modelica://AixLib.DataBase.HeatPump\">AixLib.DataBase.HeatPump</a> or polynomial functions.</p>
</html>",
      revisions="<html>
 <ul>
  <li>
  May 19, 2017, by Mirko Engelpracht:<br/>
  Added missing documentation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/391\">issue 391</a>).
  </li>
  <li>
  October 17, 2016, by Philipp Mehrfeld:<br/>
  Implemented especially for comparison to simple heat pump model.
  </li>
 </ul>
</html>
"));
end HeatPump;
