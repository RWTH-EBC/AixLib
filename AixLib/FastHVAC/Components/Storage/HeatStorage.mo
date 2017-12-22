within AixLib.FastHVAC.Components.Storage;

model HeatStorage "Simple model of a heat storage"





  /* *******************************************************************

      Medium

     ******************************************************************* */

 parameter AixLib.FastHVAC.Media.BaseClasses.MediumSimple medium=

      AixLib.FastHVAC.Media.WaterSimple()

    "Mediums charastics (heat capacity, density, thermal conductivity)"

    annotation(Dialog(group="Medium"),choicesAllMatching);



     parameter AixLib.FastHVAC.Media.BaseClasses.MediumSimple mediumHC1=

      AixLib.FastHVAC.Media.WaterSimple()

    "Mediums charastics for HC1 (heat capacity, density, thermal conductivity)"

    annotation(Dialog(group="Medium"),choicesAllMatching);



     parameter AixLib.FastHVAC.Media.BaseClasses.MediumSimple mediumHC2=

      AixLib.FastHVAC.Media.WaterSimple()

    "Mediums charastics for HC2 (heat capacity, density, thermal conductivity)"

    annotation(Dialog(group="Medium"),choicesAllMatching);



  parameter Modelica.SIunits.Temperature T_start=323.15

    "Start temperature of medium" annotation(Dialog(tab="Initialisation"));

  parameter Modelica.SIunits.Temperature T_start_wall=293.15

    "Starting Temperature of wall in K" annotation(Dialog(tab="Initialisation"));

  parameter Modelica.SIunits.Temperature T_start_ins=293.15

    "Starting Temperature of insulation in K" annotation(Dialog(tab="Initialisation"));

  /* *******************************************************************

      HeatStorage Parameters

     ******************************************************************* */



  inner parameter Real tau(min=0) = 1000 "Time constant for mixing";

  inner parameter Integer n(min=3) = 3 "Model assumptions Number of Layers";



  parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha_in=1500

    "Coefficient at the inner wall";

  parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha_out=15

    "Coefficient at the outer wall";

  inner parameter AixLib.DataBase.Storage.BufferStorageBaseDataDefinition data=

      AixLib.DataBase.Storage.Generic_500l() "Storage data"

    annotation (choicesAllMatching);

protected

   parameter Real[ 2] load_cycles= {data.hUpperPorts,data.hLowerPorts}

    "Loading cycle connection pairs (upper position first)"

    annotation (Dialog(tab="Connections"));

  parameter Real[ 2] unload_cycles = {data.hLowerPorts,data.hUpperPorts}

    "Unloading cycle connection pairs (lower position first)"

    annotation (Dialog(tab="Connections"));

public

  Modelica.SIunits.Energy Heat_loss;



  /* ***************Heating Coil Section********************************/



  parameter Boolean use_heatingCoil1=true "Use Heating Coil1?" annotation(Dialog(tab="Heating Coils and Rod"));

  parameter Boolean use_heatingCoil2=true "Use Heating Coil2?" annotation(Dialog(tab="Heating Coils and Rod"));

  parameter Boolean use_heatingRod=true "Use Heating Rod?" annotation(Dialog(tab="Heating Coils and Rod"));

  parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha_HC1=20

    "Model assumptions Coefficient of Heat Transfer HC1 <-> Heating Water" annotation(Dialog(enable = use_heatingCoil1,tab="Heating Coils and Rod"));

  parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha_HC2=400

    "Model assumptions Coefficient of Heat Transfer HC2 <-> Heating Water" annotation(Dialog(enable = use_heatingCoil2,tab="Heating Coils and Rod"));

  parameter Boolean Up_to_down_HC1 = true

    "Heating Coil 1 orientation from up to down?"

                                                 annotation(Dialog(enable = use_heatingCoil1,tab="Heating Coils and Rod"));

  parameter Boolean Up_to_down_HC2 = true

    "Heating Coil 2 orientation from up to down?"

                                                 annotation(Dialog(enable = use_heatingCoil2,tab="Heating Coils and Rod"));

//   parameter Modelica.SIunits.Length d_HC1=0.02 "Inner diameter of HC1"

//                            annotation(Dialog(enable = use_heatingCoil1,tab="Heating Coils and Rod"));

//   parameter Modelica.SIunits.Length d_HC2=0.02 "Inner diameter of HC2"

//                             annotation(Dialog(enable = use_heatingCoil2,tab="Heating Coils and Rod"));



  /* *******************************************************************

      Final Parameters

     ******************************************************************* */



 final parameter Integer n_HC1_up=integer(AixLib.Utilities.Math.Functions.round(data.hHC1Up/(data.hTank/n) + 0.5,0));

 final parameter Integer n_HC1_low=integer(AixLib.Utilities.Math.Functions.round(data.hHC1Low/(data.hTank/n) + 0.5,0));

 final parameter Integer dis_HC1 = n_HC1_up-n_HC1_low+1;



 final parameter Integer n_HR=integer(AixLib.Utilities.Math.Functions.round(data.hHR/(data.hTank/n) + 0.5,0));



 final parameter Integer n_HC2_up=integer(AixLib.Utilities.Math.Functions.round(data.hHC2Up/(data.hTank/n) + 0.5,0));

 final parameter Integer n_HC2_low=integer(AixLib.Utilities.Math.Functions.round(data.hHC2Low/(data.hTank/n) + 0.5,0));

 final parameter Integer dis_HC2 = n_HC2_up-n_HC2_low+1;



 final parameter Integer n_TS1=integer(AixLib.Utilities.Math.Functions.round(data.hTS1/(data.hTank/n) + 0.5,0));

 final parameter Integer n_TS2=integer(AixLib.Utilities.Math.Functions.round(data.hTS2/(data.hTank/n) + 0.5,0));



  /* *******************************************************************

      Components

      ******************************************************************* */



  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor layer[n](C=

        fill(data.hTank*Modelica.Constants.pi*(data.dTank/2)^2*medium.rho*medium.c

        /n, n), T(start=fill(T_start, n))) annotation (Placement(

        transformation(

        extent={{-10,-10},{10,10}},

        rotation=90,

        origin={-30,50})));



public

  FastHVAC.Interfaces.EnthalpyPort_a LoadingCycle_In annotation (Placement(

        transformation(extent={{-30,90},{-10,110}}), iconTransformation(extent={

            {-30,90},{-10,110}})));

  FastHVAC.Interfaces.EnthalpyPort_b LoadingCycle_Out annotation (Placement(

        transformation(extent={{-30,-110},{-10,-90}}), iconTransformation(

          extent={{-30,-110},{-10,-90}})));

  FastHVAC.Interfaces.EnthalpyPort_b UnloadingCycle_Out annotation (Placement(

        transformation(extent={{10,90},{30,110}}), iconTransformation(extent={{10,

            90},{30,110}})));

  FastHVAC.Interfaces.EnthalpyPort_a UnloadingCycle_In annotation (Placement(

        transformation(extent={{10,-110},{30,-90}}), iconTransformation(extent={

            {10,-110},{30,-90}})));



public

  FastHVAC.BaseClasses.EnergyBalance   energyBalance_load[n]

    annotation (Placement(transformation(

        extent={{-20,-19},{20,19}},

        rotation=270,

        origin={-41,0})));



  FastHVAC.BaseClasses.EnergyBalance   energyBalance_unload[n]

    annotation (Placement(transformation(

        extent={{-20,20},{20,-20}},

        rotation=270,

        origin={42,0})));

  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature varTemp_load[2]

    annotation (Placement(transformation(extent={{98,12},{120,32}})));

  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow dummy_load[2](each Q_flow=0)

                                                                    annotation (Placement(transformation(extent={{98,44},{118,64}})));



  FastHVAC.Interfaces.EnthalpyPort_a port_HC1_in if use_heatingCoil1

    "Fluid connector a (positive design flow direction is from port_a to port_b)"

    annotation (Placement(transformation(extent={{-110,70},{-90,90}}),

        iconTransformation(extent={{-88,52},{-72,68}})));

  FastHVAC.Interfaces.EnthalpyPort_b port_HC1_out if use_heatingCoil1

    "Fluid connector b (positive design flow direction is from port_a to port_b)"

    annotation (Placement(transformation(extent={{-110,30},{-90,50}}),

        iconTransformation(extent={{-90,12},{-74,28}})));



  FastHVAC.Interfaces.EnthalpyPort_a port_HC2_in if use_heatingCoil2

    "Fluid connector a (positive design flow direction is from port_a to port_b)"

    annotation (Placement(transformation(extent={{-110,-50},{-90,-30}}),

        iconTransformation(extent={{-90,-26},{-76,-12}})));

  FastHVAC.Interfaces.EnthalpyPort_b port_HC2_out if use_heatingCoil2

    "Fluid connector b (positive design flow direction is from port_a to port_b)"

    annotation (Placement(transformation(extent={{-110,-90},{-90,-70}}),

        iconTransformation(extent={{-90,-66},{-76,-52}})));



  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature varTemp_unload[2]

    annotation (Placement(transformation(extent={{98,-74},{120,-54}})));

  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow dummy_unload[2](each Q_flow=0)

    annotation (Placement(transformation(extent={{98,-36},{118,-16}})));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatingRod if use_heatingRod annotation (Placement(transformation(

          extent={{-110,90},{-90,110}}),iconTransformation(extent={{-70,70},{-50,

            90}})));

  Modelica.Blocks.Interfaces.RealOutput T_layers[n]( unit="K")  annotation (Placement(

        transformation(

        extent={{-10,-10},{10,10}},

        rotation=180,

        origin={-110,0}), iconTransformation(

        extent={{-10,-10},{10,10}},

        rotation=180,

        origin={-90,0})));

        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a

                           out

    annotation (Placement(transformation(extent={{90,90},{110,110}}),iconTransformation(extent={{50,70},{70,90}})));

  BaseClasses.HeatingCoil heatingCoil1(

    T_start=T_start,

    dis_HC=dis_HC1,

    alpha_HC=alpha_HC1,

    medium_HC=mediumHC1,

    length_HC=data.lengthHC1,

    pipe_HC=data.pipeHC1) if use_heatingCoil1 annotation (Placement(

        transformation(

        extent={{-15,-12},{15,12}},

        rotation=270,

        origin={-72,59})));

  BaseClasses.HeatingCoil heatingCoil2(

    T_start=T_start,

    dis_HC=dis_HC2,

    alpha_HC=alpha_HC2,

    medium_HC=mediumHC2,

    length_HC=data.lengthHC2,

    pipe_HC=data.pipeHC2) if use_heatingCoil2 annotation (Placement(

        transformation(

        extent={{-14,-12},{14,12}},

        rotation=270,

        origin={-72,-60})));

  Fluid.Storage.BaseClasses.StorageCover                  top_cover(

    D1=data.dTank)   annotation (Placement(transformation(

        extent={{-10,-10},{10,10}},

        rotation=90,

        origin={2,70})));

  Fluid.Storage.BaseClasses.StorageMantle                  storage_mantle[n](

    each height=data.hTank/n,

    each D1=data.dTank)

    annotation (Placement(transformation(extent={{70,-10},{90,10}})));

  Fluid.Storage.BaseClasses.StorageCover                  bottom_cover(

    D1=data.dTank)   annotation (Placement(transformation(

        extent={{-10,-10},{10,10}},

        rotation=270,

        origin={0,-46})));

  BaseClasses.HeatTransferOnlyConduction heatTransfer annotation (Placement(

        transformation(extent={{-8,18},{12,38}}, rotation=0)));



    replaceable model HeatTransfer =

     BaseClasses.HeatTransferOnlyConduction  constrainedby

    BaseClasses.PartialHeatTransferLayers

    "Heat Transfer Model between fluid layers" annotation (choicesAllMatching=true,

      Documentation(info =                             "<html>
<h4>
  <font color=\"#008000\">Overview</font>
</h4>
<p>
  Heat transfer model for heat transfer between two fluid layers.
</p></html>",revisions="<html>
<ul>
  <li>
    <i>October 2, 2013&#160;</i> by Ole Odendahl:<br/>
    Added documentation and formatted appropriately
  </li>
</ul>
<h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Buffer storage model with support for heating rod and two heating coils.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  It represents a buffer storage stratified into n layers where 1 represents the bottom layer and n represents the top layer. The layers are connected to each other allowing heat and fluid transfer. The conductance, buoyancy and enthalpy flow represent the heat transfer between the layers.
</p>
<p>
  The geometrical data for the storage is read by records in the DataBase package.
</p>
<p>
  The model also includes heat losses over the storage walls (wall, top and bottom).
</p>
<p>
  <br/>
  <b><font style=\"color:">Example Results</font></b>
</p>
<p>
  <a href=\"FastHVAC.Examples.Storage.BufferStorage\">BufferStorage</a>, <a href=\"FastHVAC.Examples.Storage.BufferStorageHC\">BufferStorageHC</a>
</p>
<ul>
  <li>
    <i>December 20, 2016&#160;</i> Tobias Blacha:<br/>
    Moved into AixLib
  </li>
  <li>
    <i>January 27, 2015&#160;</i> by Konstantin Finkbeiner:<br/>
    Added documentation.
  </li>
  <li>
    <i>December 16, 2014</i> by Sebastian Stinner:<br/>
    Implemented.
  </li>
</ul>

</html>"));

end HeatStorage;

