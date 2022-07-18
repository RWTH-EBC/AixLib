within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.EN1264;
function BasicCharacteristic
  "Calculation of basic characteristic according to EN 1264"
  input Modelica.Units.SI.Temperature T_Fm;
  input Modelica.Units.SI.Temperature T_Room;
  output Modelica.Units.SI.HeatFlux q_Basis;

algorithm
  q_Basis :=8.92*(T_Fm - T_Room)^1.1;

  annotation (Documentation(revisions="<html><ul>
  <li>
    <i>June 1, 2020&#160;</i> by Elaine Schmitt:<br/>
    Moved into AixLib
  </li>
  <li>
    <i>November 06, 2014&#160;</i> by Ana Constantin:<br/>
    Added documentation.
  </li>
</ul>
</html>",
      info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Calculation of heat flux that is supposed to be generated from panel
  heating with given floor temperature (Temp_in[1]) and room
  temperature (Temp_in[2]).
</p>
</html>"));
end BasicCharacteristic;
