within AixLib.DataBase;
package HeatPump "Collection of HeatPump Database Records"
   extends Modelica.Icons.Package;

  record HeatPumpBaseDataDefinition "Basic heat pump data"
      extends Modelica.Icons.Record;
    import SI = Modelica.SIunits;
    import SIconv = Modelica.SIunits.Conversions.NonSIunits;
    parameter Real tableQdot_con[:,:] "Heating power lookup table";
    parameter Real tableP_ele[:,:] "Electrical power lookup table";
    parameter SI.MassFlowRate mFlow_conNom
      "nominal mass flow rate in condenser";
    parameter SI.MassFlowRate mFlow_evaNom
      "nominal mass flow rate in evaporator";

    annotation (Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>
Base data definition used in the HeatPump model. It defines the table table_Qdot_Co which gives the condenser heat flow rate and table_Pel which gives the electric power consumption of the heat pump. Both tables define the power values depending on the evaporator inlet temperature (columns) and the evaporator outlet temperature (rows) in W. The nominal heat flow rate in the condenser and evaporator are also defined as parameters. 
</p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://AixLib/Images/stars5.png\" alt=\"stars: 5 out of 5\"/></p>
</html>", revisions="<html>
<p><ul>
<li><i>December 10, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
</ul></p>
</html>
"),  Icon,     preferedView="info");
  end HeatPumpBaseDataDefinition;

  package EN14511

    record StiebelEltron_WPL18 "Stiebel Eltron WPL 18"
      extends HeatPumpBaseDataDefinition(
        tableP_ele=[0,-7,2,7,10,20; 35,3300,3400,3500,3700,3800; 50,4500,4400,4600,5000,
            5100],
        tableQdot_con=[0,-7,2,7,10,20; 35,9700,11600,13000,14800,16300; 50,10000,11200,
            12900,16700,17500],
        mFlow_conNom=13000/4180/5,
        mFlow_evaNom=1);

      annotation(preferedView="text", DymolaStoredErrors,
        Icon,
        Documentation(revisions="<html>
<p><ul>
<li><i>December 10, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
</ul></p>
</html>
",     info=
        "<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>
according to data from WPZ Buchs, Swiss
</p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://AixLib/Images/stars5.png\" alt=\"stars: 5 out of 5\"/></p>
<p><h4><font color=\"#008000\">References</font></h4></p>
<p>
EN14511
</p>
</html>"));
    end StiebelEltron_WPL18;
  end EN14511;

  package EN255

    record Vitocal350BWH113 "Vitocal 350 BWH 113"
      extends HeatPumpBaseDataDefinition(
        tableP_ele=[0,-5.0,0.0,5.0,10.0,15.0; 35,3750,3750,3750,3750,3833; 45,4833,4917,
            4958,5042,5125; 55,5583,5667,5750,5833,5958; 65,7000,7125,7250,7417,7583],
        tableQdot_con=[0,-5.0,0.0,5.0,10.0,15.0; 35,14500,16292,18042,19750,21583; 45,
            15708,17167,18583,20083,21583; 55,15708,17167,18583,20083,21583; 65,15708,
            17167,18583,20083,21583],
        mFlow_conNom=16292/4180/10,
        mFlow_evaNom=12300/3600/3);

      annotation(preferedView="text", DymolaStoredErrors,
        Icon,
        Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>
Data from manufacturer's data sheet (Viessmann). These curves are given in the data sheet for measurement procedure according to EN 255.
</p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://AixLib/Images/stars5.png\" alt=\"stars: 5 out of 5\"/></p>
<p><h4><font color=\"#008000\">References</font></h4></p>
<p>
EN 255
</p>
</html>", revisions="<html>
<p><ul>
<li><i>December 10, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
</ul></p>
</html>
"));
    end Vitocal350BWH113;
  end EN255;
end HeatPump;
