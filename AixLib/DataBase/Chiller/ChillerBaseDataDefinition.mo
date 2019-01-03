within AixLib.DataBase.Chiller;
record ChillerBaseDataDefinition "Basic chiller data"

    extends AixLib.DataBase.HeatPump.HeatPumpBaseDataDefinition;
  annotation (Documentation(info="<html>
<p>Base data definition used in the heat pump mode for the chiller model. As it extends from the <a href=\"modelica://AixLib.DataBase.HeatPump.HeatPumpBaseDataDefinition\">HeatPumpBaseDataDefinition</a>, the parameters documentation is made for a heat pump. As a result, table_Qdot_Co corresponds to the cooling capacity on the evaporator side of the chiller (condenser of the heat pump). Furthermore, the values of the tables depend on the condenser  inlet temperature (defined in first row) and the evaporator outlet temperature (defined in first column) in W. </p>
<p>The nominal mass flow rate in the condenser and evaporator are also defined as parameters. </p>
</html>",
        revisions="<html>
<ul>
<li>
<i>November 26, 2018&nbsp;</i> by Fabian Wüllhorst: <br/>
First implementation (see issue <a href=\"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
</li>
</ul>
</html>"),
   Icon,     preferedView="info");
end ChillerBaseDataDefinition;
