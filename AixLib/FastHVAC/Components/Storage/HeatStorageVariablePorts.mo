within AixLib.FastHVAC.Components.Storage;

model HeatStorageVariablePorts "Simple model of a heat storage"



  /* *******************************************************************

      Medium

     ******************************************************************* */



public

  parameter FastHVAC.Media.BaseClasses.MediumSimple medium=

      FastHVAC.Media.WaterSimple()

    "Mediums charastics (heat capacity, density, thermal conductivity)"

    annotation(Dialog(group="Medium"),choicesAllMatching);



    parameter FastHVAC.Media.BaseClasses.MediumSimple mediumHC1=

      FastHVAC.Media.WaterSimple()

    "Mediums charastics for HC1 (heat capacity, density, thermal conductivity)"

    annotation(Dialog(group="Medium"),choicesAllMatching);



     parameter FastHVAC.Media.BaseClasses.MediumSimple mediumHC2=

      FastHVAC.Media.WaterSimple()

    "Mediums charastics HC2 (heat capacity, density, thermal conductivity)"

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

  inner parameter Integer n(min=3) = 5 "Model assumptions Number of Layers";



  parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha_in=1500

    "Coefficient at the inner wall";

  parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha_out=15

    "Coefficient at the outer wall";

  inner parameter AixLib.DataBase.Storage.BufferStorageBaseDataDefinition data=

      AixLib.DataBase.Storage.Generic_500l() "Storage data"

    annotation (choicesAllMatching);

  parameter Integer[n_load_cycles, 2] load_cycles= {{n,1},{n,1}}

    "Loading cycle connection pairs (upper position first)"

    annotation (Dialog(tab="Connections"));

  parameter Integer[n_unload_cycles, 2] unload_cycles = {{1,n},{1,n}}

    "Unloading cycle connection pairs (lower position first)"

    annotation (Dialog(tab="Connections"));



  Modelica.SIunits.Energy Heat_loss;

  parameter Integer n_load_cycles=2 "Number of loading cycle connection pairs"

    annotation (Dialog(tab="Connections"));

   parameter Integer n_unload_cycles=2

    "Number of loading cycle connection pairs"

     annotation (Dialog(tab="Connections"));



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

//                             annotation(Dialog(enable = use_heatingCoil1,tab="Heating Coils and Rod"));

//   parameter Modelica.SIunits.Length d_HC2=0.02 "Inner diameter of HC2"

//                             annotation(Dialog(enable = use_heatingCoil2,tab="Heating Coils and Rod"));



  /* *******************************************************************

      Final Parameters

     ******************************************************************* */



 parameter Integer n_HC1_up=n "Highest layer of Heating Coil 1"                                                                      annotation (Dialog(tab="Connections"));

 parameter Integer n_HC1_low=1 "Lowest layer of Heating Coil 1"                                                                       annotation (Dialog(tab="Connections"));

  parameter Integer n_HC2_up=n "Highest layer of Heating Coil 2"                                                                          annotation (Dialog(tab="Connections"));

 parameter Integer n_HC2_low=1 "Lowest layer of Heating Coil 2"                                                                          annotation (Dialog(tab="Connections"));



 parameter Integer n_HR=n "Layer of Heating Rod"                                                                  annotation (Dialog(tab="Connections"));



 final parameter Integer dis_HC1 = n_HC1_up-n_HC1_low+1;

 final parameter Integer dis_HC2 = n_HC2_up-n_HC2_low+1;



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

  FastHVAC.Interfaces.EnthalpyPort_a LoadingCycle_In[n_load_cycles] annotation (

     Placement(transformation(extent={{-30,90},{-10,110}}), iconTransformation(

          extent={{-30,90},{-10,110}})));

  FastHVAC.Interfaces.EnthalpyPort_b LoadingCycle_Out[n_load_cycles]

    annotation (Placement(transformation(extent={{-30,-110},{-10,-90}}),

        iconTransformation(extent={{-30,-110},{-10,-90}})));

  FastHVAC.Interfaces.EnthalpyPort_b UnloadingCycle_Out[n_unload_cycles]

    annotation (Placement(transformation(extent={{10,90},{30,110}}),

        iconTransformation(extent={{10,90},{30,110}})));

  FastHVAC.Interfaces.EnthalpyPort_a UnloadingCycle_In[n_unload_cycles]

    annotation (Placement(transformation(extent={{10,-110},{30,-90}}),

        iconTransformation(extent={{10,-110},{30,-90}})));



public

  FastHVAC.BaseClasses.EnergyBalance   energyBalance_load[n,n_load_cycles]

    annotation (Placement(transformation(

        extent={{-20,-19},{20,19}},

        rotation=270,

        origin={-39,0})));



  FastHVAC.BaseClasses.EnergyBalance   energyBalance_unload[n,n_unload_cycles]

    annotation (Placement(transformation(

        extent={{-20,20},{20,-20}},

        rotation=270,

        origin={40,0})));

  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature varTemp_load[

    n_load_cycles,2]

    annotation (Placement(transformation(extent={{100,14},{122,34}})));

  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow dummy_load[n_load_cycles,

    2](each Q_flow=0)

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



  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature varTemp_unload[

    n_unload_cycles,2]

    annotation (Placement(transformation(extent={{98,-60},{120,-40}})));

  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow dummy_unload[

    n_unload_cycles,2](each Q_flow=0)

    annotation (Placement(transformation(extent={{98,-36},{118,-16}})));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatingRod if use_heatingRod annotation (Placement(transformation(

          extent={{-110,90},{-90,110}}),iconTransformation(extent={{-70,70},{-50,

            90}})));

  Modelica.Blocks.Interfaces.RealOutput T_layers[n](  unit="K") annotation (Placement(

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

    lengthHC=data.lengthHC1,

    pipeRecordHC=data.pipeHC1) if   use_heatingCoil1 annotation (Placement(

        transformation(

        extent={{-15,-12},{15,12}},

        rotation=270,

        origin={-72,59})));

  BaseClasses.HeatingCoil heatingCoil2(

    T_start=T_start,

    dis_HC=dis_HC2,

    alpha_HC=alpha_HC2,

    medium_HC=mediumHC2,

    lengthHC=data.lengthHC2,

    pipeRecordHC=data.pipeHC2) if   use_heatingCoil2 annotation (Placement(

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

    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Fluid.Storage.BaseClasses.StorageCover                  bottom_cover(

    D1=data.dTank)   annotation (Placement(transformation(

        extent={{-10,-10},{10,10}},

        rotation=270,

        origin={0,-38})));



        HeatTransfer heatTransfer annotation (Placement(transformation(extent={{-8,18},

            {12,38}},  rotation=0)));



 replaceable model HeatTransfer =

     BaseClasses.HeatTransferOnlyConduction constrainedby

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
  Buffer storage model with support for heating rod and two heating coils. Model with variable connection pairs for loading and unlouding cycles which are defined by the associated <u>storage layer number</u> of the ports.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  It represents a buffer storage stratified into n layers where 1 represents the bottom layer and n represents the top layer. The layers are connected to each other allowing heat and fluid transfer. The conductance, buoyancy and enthalpy flow represent the heat transfer between the layers.
</p>
<p>
  The geometrical data for the storage is read by records in the DataBase package. In this model the number and the position of connection pairs for loading and unlouding cycles is variable. The position for each connection pair is defined by the associated storage layer number of input and output connection (compare connections tab).
</p>
<p>
  The model also includes heat losses over the storage walls (wall, top and bottom).
</p>
<p>
  <br/>
  <b><font style=\"color:">Example Results</font></b>
</p>
<p>
  <a href=\"FastHVAC.Examples.Storage.BufferStorage_variablePorts\">BufferStorage_variablePorts</a>
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

end HeatStorageVariablePorts;

