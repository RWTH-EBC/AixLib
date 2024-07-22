within AixLib.ThermalZones.ReducedOrder.Validation;
model RoomSteadyState
  "Validation model that checks whether all weather data is set to a constant"
  extends ThermalZones.ReducedOrder.Examples.SimpleRoomOneElement(
    weaDat(
      pAtmSou=AixLib.BoundaryConditions.Types.DataSource.Parameter,
      ceiHeiSou=AixLib.BoundaryConditions.Types.DataSource.Parameter,
      totSkyCovSou=AixLib.BoundaryConditions.Types.DataSource.Parameter,
      opaSkyCovSou=AixLib.BoundaryConditions.Types.DataSource.Parameter,
      TDryBulSou=AixLib.BoundaryConditions.Types.DataSource.Parameter,
      TDewPoiSou=AixLib.BoundaryConditions.Types.DataSource.Parameter,
      TBlaSkySou=AixLib.BoundaryConditions.Types.DataSource.Parameter,
      TBlaSky=293.15,
      relHumSou=AixLib.BoundaryConditions.Types.DataSource.Parameter,
      winSpeSou=AixLib.BoundaryConditions.Types.DataSource.Parameter,
      winDirSou=AixLib.BoundaryConditions.Types.DataSource.Parameter,
      HInfHorSou=AixLib.BoundaryConditions.Types.DataSource.Parameter,
      HSou=AixLib.BoundaryConditions.Types.RadiationDataSource.Input_HGloHor_HDifHor),
    intGai(table=[0,0,0,0; 86400,0,0,0]),
    thermalZoneOneElement(T_start=293.15));

  Modelica.Blocks.Sources.Constant zer(k=0) "Zero input signal"
    annotation (Placement(transformation(extent={{-134,44},{-114,64}})));
equation
  connect(zer.y, weaDat.HDifHor_in) annotation (Line(points={{-113,54},{-106,54},
          {-106,52.5},{-99,52.5}}, color={0,0,127}));
  connect(zer.y, weaDat.HGloHor_in) annotation (Line(points={{-113,54},{-106,54},
          {-106,49},{-99,49}}, color={0,0,127}));
  annotation (
    experiment(
      StopTime=604800,
      Tolerance=1e-06),
      __Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/ThermalZones/ReducedOrder/Validation/RoomSteadyState.mos"
        "Simulate and plot"),
    Diagram(coordinateSystem(extent={{-140,-100},{100,100}})),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})),
    Documentation(info="<html>
<p>
This model validates that the RC network model starts at and remains at exactly <i>20</i>&deg;C
if there is no solar radiation and constant outdoor conditions.
</p>
</html>", revisions="<html>
<ul>
<li>
April 14, 2020, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end RoomSteadyState;
