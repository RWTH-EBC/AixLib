within AixLib.Systems.Benchmark.Model.Evaluation;
package CCCS "calculating the overall costs  according to CCCS evaluation method to evaluate the performance of control strategies"
  extends Modelica.Icons.Package;


public
  block DiscountingFactor "discounting factor to be multiplied by the operational costs as part of the overall costs of a control strategy according to CCCS evaluation method"
    extends Modelica.Blocks.Interfaces.SI2SO;

    parameter Real k1=+1 "Gain of upper input";
    parameter Real k2=+1 "Gain of lower input";

  equation
    y = (k1*u1)^(k2*u2);
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Text(
            lineColor={0,0,255},
            extent={{-150,110},{150,150}},
            textString="DiscountingFactor"),
          Text(extent={{-38,-34},{38,34}}, textString="DiscountingFactor"),
          Text(extent={{-100,52},{5,92}}, textString="q"),
          Text(extent={{-100,-92},{5,-52}}, textString="t")}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={Rectangle(
              extent={{-100,-100},{100,100}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Text(
              extent={{-36,38},{40,-30}},
              lineColor={0,0,0},
              textString="DiscountingFactor"),Text(
              extent={{-100,52},{5,92}},
              lineColor={0,0,0},
              textString="q"),Text(
              extent={{-100,-52},{5,-92}},
              lineColor={0,0,0},
              textString="t")}));
  end DiscountingFactor;
public

  model EnergyCosts "calculating the energy costs as part of the operational costs to evaluate the performance of a control strategy according to CCCS evaluation method"





    Modelica.Blocks.Math.Gain CostFactorHeat(k=49.41)
      annotation (Placement(transformation(extent={{-130,102},{-110,122}})));
    Modelica.Blocks.Sources.Constant Constant(k=-30) annotation (Placement(
          transformation(
          extent={{-10,-11},{10,11}},
          rotation=0,
          origin={-110,39})));
    Modelica.Blocks.Sources.Constant FixedCostsConnectionHeat(k=1690)
      annotation (Placement(transformation(extent={{-48,28},{-28,48}})));
    Modelica.Blocks.Math.Gain CostFactorConnectionHeat(k=27.14)
      annotation (Placement(transformation(extent={{-48,62},{-28,82}})));
    Modelica.Blocks.Math.Gain CostFactorCold(k=81)
      annotation (Placement(transformation(extent={{-134,-2},{-114,18}})));
    Modelica.Blocks.Sources.Constant FixedCostsConnectionCold(k=1690)
      annotation (Placement(transformation(extent={{-50,-76},{-30,-56}})));
    Modelica.Blocks.Math.Gain CostFactorConnectionCold(k=27.14)
      annotation (Placement(transformation(extent={{-50,-42},{-30,-22}})));
    Modelica.Blocks.Math.Gain CostFactorElictricity(k=235)
      annotation (Placement(transformation(extent={{-134,-110},{-114,-90}})));
    Modelica.Blocks.Interfaces.RealInput Power_Heat
      annotation (Placement(transformation(extent={{-220,92},{-180,132}})));
    Modelica.Blocks.Interfaces.RealInput Power_Cold
      annotation (Placement(transformation(extent={{-222,-10},{-182,30}})));
    Modelica.Blocks.Interfaces.RealInput Power_Electricity
      annotation (Placement(transformation(extent={{-220,-120},{-180,-80}})));
    Modelica.Blocks.Interfaces.RealOutput EnergyCost
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    Modelica.Blocks.Interfaces.RealInput P_Hot
      annotation (Placement(transformation(extent={{-220,42},{-180,82}})));
    Modelica.Blocks.Interfaces.RealInput P_Cold
      annotation (Placement(transformation(extent={{-220,-66},{-180,-26}})));
    Modelica.Blocks.Math.MultiSum Sum_EnergyCost(nu=3)
      annotation (Placement(transformation(extent={{68,0},{80,12}})));
    Modelica.Blocks.Math.MultiSum Cost_cold(nu=2)
      annotation (Placement(transformation(extent={{28,0},{40,12}})));
    Modelica.Blocks.Math.MultiSum PowerConnection_cold(nu=2)
      annotation (Placement(transformation(extent={{-76,-40},{-64,-28}})));
    Modelica.Blocks.Math.MultiSum CostConnectio_cold(nu=1)
      annotation (Placement(transformation(extent={{-4,-38},{8,-26}})));
    Modelica.Blocks.Math.MultiSum PowerConnection_heat(nu=2)
      annotation (Placement(transformation(extent={{-76,66},{-64,78}})));
    Modelica.Blocks.Math.MultiSum CostConnectio_heat(nu=2)
      annotation (Placement(transformation(extent={{-6,68},{6,80}})));
    Modelica.Blocks.Math.MultiSum Cost_heat(nu=2)
      annotation (Placement(transformation(extent={{52,70},{64,82}})));
  equation

    connect(Power_Heat, CostFactorHeat.u)
      annotation (Line(points={{-200,112},{-132,112}}, color={0,0,127}));
    connect(CostFactorCold.u, Power_Cold) annotation (Line(points={{-136,8},{
            -168,8},{-168,10},{-202,10}}, color={0,0,127}));
    connect(Power_Electricity, CostFactorElictricity.u)
      annotation (Line(points={{-200,-100},{-136,-100}}, color={0,0,127}));
    connect(Sum_EnergyCost.y, EnergyCost) annotation (Line(points={{81.02,6},{
            92,6},{92,0},{110,0}}, color={0,0,127}));
    connect(CostFactorElictricity.y, Sum_EnergyCost.u[1]) annotation (Line(
          points={{-113,-100},{68,-100},{68,8.8}}, color={0,0,127}));
    connect(Cost_cold.y, Sum_EnergyCost.u[2]) annotation (Line(points={{41.02,6},
            {54,6},{54,6},{68,6}}, color={0,0,127}));
    connect(CostFactorCold.y, Cost_cold.u[1]) annotation (Line(points={{-113,8},
            {-42,8},{-42,8.1},{28,8.1}}, color={0,0,127}));
    connect(Constant.y, PowerConnection_cold.u[1]) annotation (Line(points={{
            -99,39},{-99,1.5},{-76,1.5},{-76,-31.9}}, color={0,0,127}));
    connect(P_Cold, PowerConnection_cold.u[2]) annotation (Line(points={{-200,
            -46},{-138,-46},{-138,-36.1},{-76,-36.1}}, color={0,0,127}));
    connect(PowerConnection_cold.y, CostFactorConnectionCold.u) annotation (
        Line(points={{-62.98,-34},{-58,-34},{-58,-32},{-52,-32}}, color={0,0,
            127}));
    connect(CostFactorConnectionCold.y, CostConnectio_cold.u[1])
      annotation (Line(points={{-29,-32},{-4,-32}}, color={0,0,127}));
    connect(CostConnectio_cold.y, Cost_cold.u[2]) annotation (Line(points={{
            9.02,-32},{9.02,-14},{28,-14},{28,3.9}}, color={0,0,127}));
    connect(Constant.y, PowerConnection_heat.u[1]) annotation (Line(points={{
            -99,39},{-99,54.5},{-76,54.5},{-76,74.1}}, color={0,0,127}));
    connect(P_Hot, PowerConnection_heat.u[2]) annotation (Line(points={{-200,62},
            {-138,62},{-138,69.9},{-76,69.9}}, color={0,0,127}));
    connect(PowerConnection_heat.y, CostFactorConnectionHeat.u)
      annotation (Line(points={{-62.98,72},{-50,72}}, color={0,0,127}));
    connect(CostFactorConnectionHeat.y, CostConnectio_heat.u[1]) annotation (
        Line(points={{-27,72},{-18,72},{-18,76.1},{-6,76.1}}, color={0,0,127}));
    connect(FixedCostsConnectionHeat.y, CostConnectio_heat.u[2]) annotation (
        Line(points={{-27,38},{-16,38},{-16,71.9},{-6,71.9}}, color={0,0,127}));
    connect(CostConnectio_heat.y, Cost_heat.u[1]) annotation (Line(points={{
            7.02,74},{30,74},{30,78.1},{52,78.1}}, color={0,0,127}));
    connect(CostFactorHeat.y, Cost_heat.u[2]) annotation (Line(points={{-109,
            112},{-28,112},{-28,73.9},{52,73.9}}, color={0,0,127}));
    connect(Cost_heat.y, Sum_EnergyCost.u[3]) annotation (Line(points={{65.02,
            76},{66,76},{66,3.2},{68,3.2}}, color={0,0,127}));
    annotation (Diagram(graphics={
                             Text(
              extent={{-106,12},{-1,52}},
              lineColor={0,0,0},
              textString=""),Text(
              extent={{-106,-18},{-1,-58}},
              lineColor={0,0,0},
              textString="")}),
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Text(
            lineColor={0,0,255},
            extent={{-150,110},{150,150}},
            textString="EnergyCosts"),
          Text(extent={{-38,-34},{38,34}}, textString="EnergyCosts"),
          Text(extent={{-100,52},{5,92}}, textString=""),
          Text(extent={{-100,-92},{5,-52}}, textString="")}));
  end EnergyCosts;

  model EmissionsCosts "calculating the costs for emissions as part of the operational costs to evaluate the performance of a control strategy according to CCCS evaluation method"
    Modelica.Blocks.Math.Gain EmissionsFactorHeat(k=0.2)
      annotation (Placement(transformation(extent={{-38,24},{-18,44}})));
    Modelica.Blocks.Math.Gain EmissionsFactorCold(k=0.527)
      annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
    Modelica.Blocks.Math.Gain EmissionsFactorElectricity(k=0.626)
      annotation (Placement(transformation(extent={{-38,-44},{-18,-24}})));
    Modelica.Blocks.Math.Sum Emissions(nin=3)
      annotation (Placement(transformation(extent={{-6,-10},{14,10}})));
    Modelica.Blocks.Math.Gain CostFactorEmissions(k=19.51)
      annotation (Placement(transformation(extent={{28,-10},{48,10}})));
    Modelica.Blocks.Interfaces.RealOutput Emission_Cost
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    Modelica.Blocks.Interfaces.RealInput Power_Heat
      annotation (Placement(transformation(extent={{-140,14},{-100,54}})));
    Modelica.Blocks.Interfaces.RealInput Power_Cold
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    Modelica.Blocks.Interfaces.RealInput Power_Electricity
      annotation (Placement(transformation(extent={{-140,-54},{-100,-14}})));
  equation
    connect(Emissions.y,CostFactorEmissions. u)
      annotation (Line(points={{15,0},{26,0}},        color={0,0,127}));
    connect(Power_Heat, EmissionsFactorHeat.u)
      annotation (Line(points={{-120,34},{-40,34}}, color={0,0,127}));
    connect(CostFactorEmissions.y, Emission_Cost)
      annotation (Line(points={{49,0},{110,0}}, color={0,0,127}));
    connect(Power_Cold, EmissionsFactorCold.u)
      annotation (Line(points={{-120,0},{-42,0}}, color={0,0,127}));
    connect(Power_Electricity, EmissionsFactorElectricity.u)
      annotation (Line(points={{-120,-34},{-40,-34}}, color={0,0,127}));
    connect(Emission_Cost, Emission_Cost)
      annotation (Line(points={{110,0},{110,0}}, color={0,0,127}));
    connect(EmissionsFactorHeat.y, Emissions.u[1]) annotation (Line(points={{
            -17,34},{-12,34},{-12,-1.33333},{-8,-1.33333}}, color={0,0,127}));
    connect(EmissionsFactorCold.y, Emissions.u[2]) annotation (Line(points={{
            -19,0},{-14,0},{-14,0},{-8,0}}, color={0,0,127}));
    connect(EmissionsFactorElectricity.y, Emissions.u[3]) annotation (Line(
          points={{-17,-34},{-14,-34},{-14,1.33333},{-8,1.33333}}, color={0,0,
            127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false), graphics={
                                    Rectangle(
              extent={{308,-308},{788,354}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}));
  end EmissionsCosts;

  model PerformanceReductionCosts "calculating the costs due to reduced performance of employees caused by reduced air quality as part of the operational costs to evaluate the performance of a control strategy according to CCCS evaluation method"


  parameter Real G;                // average salary of employee p.a.
  parameter Real C_Prod;           // factor of productivity according to CCCS evaulation mehtod
  Real C_CO2_Canteen;             //level of CO2 in canteen
  Real C_CO2_Workshop;            //level of CO2 in workshop
  Real C_CO2_ConferenceRoom;      //level of CO2 in conference room
  Real C_CO2_MultiPersonOffice;   //level of CO2 in muliperson office
  Real C_CO2_OpenPlanOffice;      //level of CO2 in open plan office
  Real X_Canteen;                 //level of humidity in canteen
  Real X_Workshop;                //level of humidity in workshop
  Real X_ConferenceRoom;          //level of humidty in conference room
  Real X_MultiPersonOffice;       //level of humidty in multipersonoffice
  Real X_OpenPLanOffice;          //level of humidity in open plan opffice
  Real LRM_TX_Canteen;            //performance reduction coefficient due to temperature and humidity levels in canteen
  Real LRM_TX_Workshop;           //performance reduction coefficient due to temperature and humidity levels in workshop
  Real LRM_TX_ConferenceRoom;     //performance reduction coefficient due to temperature and humidity levels in conference room
  Real LRM_TX_MultiPersonOffice;  //performance reduction coefficient due to temperature and humidity levels in multipersonoffice
  Real LRM_TX_OpenPlanOffice;     //performance reduction coefficient due to temperature and humidity levels in open plan office
  Real LRM_CO2_Canteen;           //performance reduction coefficient due to CO2 level in canteen
  Real LRM_CO2_Workshop;          //performance reduction coefficient due to CO2 level in canteen
  Real LRM_CO2_ConferenceRoom;    //performance reduction coefficient due to CO2 level in canteen
  Real LRM_CO2_MultiPersonOffice; //performance reduction coefficient due to CO2 level in canteen
  Real LRM_CO2_OpenPlanOffice;    //performance reduction coefficient due to CO2 level in canteen
  Real K_LRM_Canteen;             //Costs for overall performance reduction in canteen
  Real K_LRM_Workshop;            //Costs for overall performance reduction in workshop
  Real K_LRM_ConferenceRoom;      //Costs for overall performance reduction in conference room
  Real K_LRM_MultiPersonOffice;   //Costs for overall performance reduction in multipersonoffice
  Real K_LRM_OpenPlanOffice;      //Costs for overall performance reduction in open plan office
  Real K_LRM;                     //Costs for overall performance reduction


  equation


    //performance reduction due to temperature and humidity levels









     //performance reduction due to CO2 level
     //Performance reduction due to CO2 level might not be considered because there is no information about CO2 levels in the rooms

     LRM_CO2_Canteen=0.0000575*C_CO2_Canteen-0.023;
     LRM_CO2_Workshop=0.0000575*C_CO2_Workshop-0.023;
     LRM_CO2_ConferenceRoom=0.0000575*C_CO2_ConferenceRoom-0.023;
     LRM_CO2_MultiPersonOffice=0.0000575*C_CO2_MultiPersonOffice-0.023;
     LRM_CO2_OpenPlanOffice=0.0000575*C_CO2_OpenPlanOffice-0.023;


     //Performance reduction due to VOC level is not considered because there is no information about VOC levels in the rooms


     //Costs due to performance reduction

     K_LRM_Canteen=G*C_Prod/(233*8*60)*sum( (t*(1-(1-LRM_TX_Canteen)*(1-LRM_CO2_Canteen))));
     K_LRM_Workshop=G*C_Prod/(233*8*60)*sum( (t*(1-(1-LRM_TX_Workshop)*(1-LRM_CO2_Workshop))));
     K_LRM_ConferenceRoom=G*C_Prod/(233*8*60)*sum( (t*(1-(1-LRM_TX_ConferenceRoom)*(1-LRM_CO2_ConferenceRoomn))));
     K_LRM_MultiPersonOffice=G*C_Prod/(233*8*60)*sum( (t*(1-(1-LRM_TX_MultiPersonOffice)*(1-LRM_CO2_MultiPersonOffice))));
     K_LRM_OpenPlanOffice=G*C_Prod/(233*8*60)*sum( (t*(1-(1-LRM_TX_OpenPlanOffice)*(1-LRM_CO2_OpenPlanOffice))));


     //overall costs due to performance reduction

     K_LRM = K_LRM_Canteen + K_LRM_Workshop + K_LRM_ConferenceRoom + K_LRM_MultiPersonOffice;

    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Text(
            lineColor={0,0,255},
            extent={{-150,110},{150,150}},
            textString="EnergyCosts"),
          Text(extent={{-38,-34},{38,34}}, textString="PerformanceReductionCosts"),
          Text(extent={{-100,52},{5,92}}, textString=""),
          Text(extent={{-100,-92},{5,-52}}, textString="")}),
        __Dymola_DymolaStoredErrors(thetext="model PerformanceReductionCosts \"calculating the costs due to reduced performance of employees caused by reduced air quality as part of the operational costs to evaluate the performance of a control strategy according to CCCS evaluation method\"
  
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Text(
          lineColor={0,0,255},
          extent={{-150,110},{150,150}},
          textString=\"PerformanceReductionCosts\"),
        Text(extent={{-38,-34},{38,34}}, textString=\"PerformanceReductionCosts\"),
        Text(extent={{-100,52},{5,92}}, textString=\"\"),
        Text(extent={{-100,-92},{5,-52}}, textString=\"\")}));
  
BusSystems.Bus_measure bus_measure
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
    
    
 Modelica.Blocks.Interfaces.RealOutput PerformanceReductionCost;   
    
    
    
//parameters      
parameter Real G=50000;                     // average salary of employee p.a.
parameter Real C_Prod=1.2;                // factor of productivity according to CCCS evaulation mehtod
parameter Real T_Set=293.15;             // set temperature canteen
parameter Real T_UpperBound=2;            // maximal positive deviation from set temperature
parameter Real T_LowerBound=-2;            // maximalnegative  deviation from set temperature
parameter Real T_Set_Workshop;   // set temperature workshop

//temperature deviation
Real deltaT_Canteen;                  //deviation from set temperature in canteen
Real deltaT_Workshop;                 //deviation from set temperature in workshop
Real deltaT_ConferenceRoom;           //deviation from set temperature in conference room
Real deltaT_MultiPersonOffice;        //deviation from set temperature in multiperson office
Real deltaT_OpenPlanOffice;           //deviation from set temperature in open plan office

//level of CO2
//Real C_CO2_Canteen;                   //level of CO2 in canteen
//Real C_CO2_Workshop;                  //level of CO2 in workshop
//Real C_CO2_ConferenceRoom;            //level of CO2 in conference room
//Real C_CO2_MultiPersonOffice;         //level of CO2 in muliperson office
//Real C_CO2_OpenPlanOffice;            //level of CO2 in open plan office



//performance reduction factors
Real LRM_TX_Canteen;                  //performance reduction coefficient due to temperature and humidity levels in canteen
Real LRM_TX_Workshop;                 //performance reduction coefficient due to temperature and humidity levels in workshop
Real LRM_TX_ConferenceRoom;           //performance reduction coefficient due to temperature and humidity levels in conference room
Real LRM_TX_MultiPersonOffice;        //performance reduction coefficient due to temperature and humidity levels in multiperson office
Real LRM_TX_OpenPlanOffice;           //performance reduction coefficient due to temperature and humidity levels in open plan office
Real LRM_CO2_Canteen;                 //performance reduction coefficient due to CO2 level in canteen
Real LRM_CO2_Workshop;                //performance reduction coefficient due to CO2 level in workshop
Real LRM_CO2_ConferenceRoom;          //performance reduction coefficient due to CO2 level in conference room
Real LRM_CO2_MultiPersonOffice;       //performance reduction coefficient due to CO2 level in multiperson office
Real LRM_CO2_OpenPlanOffice;          //performance reduction coefficient due to CO2 level in open plan office


//performance reduction costs
Real K_LRM_Canteen;                   //Costs for overall performance reduction in canteen
Real K_LRM_Workshop;                  //Costs for overall performance reduction in workshop
Real K_LRM_ConferenceRoom;            //Costs for overall performance reduction in conference room
Real K_LRM_MultiPersonOffice;         //Costs for overall performance reduction in multiperson office
Real K_LRM_OpenPlanOffice;            //Costs for overall performance reduction in open plan office
Real K_LRM;                           //Costs for overall performance reduction


equation
  
  //calclulating temperature deviations
  
  deltaT_Canteen= bus_measure.RoomTemp_Canteen-T_Set;
  deltaT_Workshop=  bus_measure.RoomTemp_Workshop-T_Set_Workshop;
  deltaT_ConferenceRoom=bus_measure.RoomTemp_Conferenceroom- T_Set;
  deltaT_MultiPersonOffice= bus_measure.RoomTemp_Multipersonoffice- T_Set ; 
  deltaT_OpenPlanOffice= bus_measure.RoomTemp_Openplanoffice-T_Set;
 
  
  //performance reduction due to temperature and humidity levels
  

  //Canteen
  
 
   
     if X<0.25
  then if deltaT_Canteen<T_LowerBound then
       LRM_TX_Canteen = 0.2*(-4*bus_measure.X_Canteen+1) + 0.04*(abs(deltaT_Canteen)-2);
       elseif deltaT_Canteen>T_UpperBound then
           LRM_TX_Canteen = 0.2*(-4*bus_measure.X_Canteen+1) + 0.02*(abs(deltaT_Canteen)-2);
          else
          LRM_TX_Canteen = 0.2*(-4*bus_measure.X_Canteen+1);
         end if;
         
        
       if X>0.65 then
if deltaT_Canteen<T_LowerBound then
  LRM_TX_Canteen = (bus_measure.X_Canteen-0.65)*0.42 + 0.04*(abs(deltaT_Canteen)-2);
  
elseif deltaT_Canteen>T_UpperBound then
    LRM_TX_Canteen = (bus_measure.X_Canteen-0.65)*(0.42+deltaT_Canteen) + 0.02*(deltaT_Canteen-2);
else
  LRM_TX_Canteen =  (bus_measure.X_Canteen-0.65)*0.42;
end if;

           
else
   if  deltaT_Canteen<T_LowerBound then          
         LRM_TX_Canteen = 0.04*(abs(deltaT_Canteen)-2);
   elseif    deltaT_Canteen>T_UpperBound then
          LRM_TX_Canteen = 0.02*(deltaT_Canteen-2);
   else
      LRM_TX_Canteen =  0;
   end if;   
  
  // Workshop
  
  if X<0.25
  then if deltaT_Workshop<T_LowerBound then
       LRM_TX_Workshop = 0.2*(-4*bus_measure.X_Workshop+1) + 0.04*(abs(deltaT_Workshop)-2);
       elseif deltaT_Workshop>T_UpperBound then
           LRM_TX_Workshop = 0.2*(-4*bus_measure.X_Workshop+1) + 0.02*(abs(deltaT_Workshop)-2);
          else
          LRM_TX_Workshop = 0.2*(-4*bus_measure.X_Workshop+1);
         end if;
         
        
       if X>0.65 then
if deltaT_Workshop<T_LowerBound then
  LRM_TX_Workshop = (bus_measure.X_Workshop-0.65)*0.42 + 0.04*(abs(deltaT_Workshop)-2);
  
elseif deltaT_Workshop>T_UpperBound then
    LRM_TX_Workshop = (bus_measure.X_Workshop-0.65)*(0.42+deltaT_Workshop) + 0.02*(deltaT_Workshop-2);
else
  LRM_TX_Workshop =  (bus_measure.X_Workshop-0.65)*0.42;
end if;

           
else
   if  deltaT_Workshop<T_LowerBound then          
         LRM_TX_Workshop = 0.04*(abs(deltaT_Workshop)-2);
   elseif    deltaT_Workshop>T_UpperBound then
          LRM_TX_Workshop = 0.02*(deltaT_Workshop-2);
   else
      LRM_TX_Workshop =  0;
   end if;                                               
                           
                         
  

  
  // conference room
  
   if X<0.25
  then if deltaT_ConferenceRoom<T_LowerBound then
       LRM_TX_ConferenceRoom = 0.2*(-4*bus_measure.X_Conferenceroom+1) + 0.04*(abs(deltaT_ConferenceRoom)-2);
       elseif deltaT_ConferenceRoom>T_UpperBound then
           LRM_TX_ConferenceRoom = 0.2*(-4*bus_measure.X_Conferenceroom+1) + 0.02*(abs(deltaT_ConferenceRoom)-2);
          else
          LRM_TX_ConferenceRoom = 0.2*(-4*bus_measure.X_Conferenceroom+1);
         end if;
         
        
       if X>0.65 then
if deltaT_ConferenceRoom<T_LowerBound then
  LRM_TX_ConferenceRoom = (bus_measure.X_Conferenceroom-0.65)*0.42 + 0.04*(abs(deltaT_ConferenceRoom)-2);
  
elseif deltaT_ConferenceRoom>T_UpperBound then
    LRM_TX_ConferenceRoom = (bus_measure.X_Conferenceroom-0.65)*(0.42+deltaT_ConferenceRoom) + 0.02*(deltaT_ConferenceRoom-2);
else
  LRM_TX_ConferenceRoom =  (bus_measure.X_Conferenceroom-0.65)*0.42;
end if;

           
else
   if  deltaT_ConferenceRoom<T_LowerBound then          
         LRM_TX_ConferenceRoom = 0.04*(abs(deltaT_ConferenceRoom)-2);
   elseif    deltaT_ConferenceRoom>T_UpperBound then
          LRM_TX_ConferenceRoom = 0.02*(deltaT_ConferenceRoom-2);
   else
      LRM_TX_ConferenceRoom =  0;
   end if;                                               
                       
  
  
  // multiperson office
  
   if X<0.25
  then if deltaT_MultiPersonOffice<T_LowerBound then
       LRM_TX_MultiPersonOffice = 0.2*(-4*bus_measure.X_Multipersonoffice+1) + 0.04*(abs(deltaT_MultiPersonOffice)-2);
       elseif deltaT_MultiPersonOffice>T_UpperBound then
           LRM_TX_MultiPersonOffice = 0.2*(-4*bus_measure.X_Multipersonoffice+1) + 0.02*(abs(deltaT_MultiPersonOffice)-2);
          else
          LRM_TX_MultiPersonOffice = 0.2*(-4*bus_measure.X_Multipersonoffice+1);
         end if;
         
        
       if X>0.65 then
if deltaT_MultiPersonOffice<T_LowerBound then
  LRM_TX_MultiPersonOffice = (bus_measure.X_Multipersonoffice-0.65)*0.42 + 0.04*(abs(deltaT_MultiPersonOffice)-2);
  
elseif deltaT_MultiPersonOffice>T_UpperBound then
    LRM_TX_MultiPersonOffice = (bus_measure.X_Multipersonoffice-0.65)*(0.42+deltaT_MultiPersonOffice) + 0.02*(deltaT_MultiPersonOffice-2);
else
  LRM_TX_MultiPersonOffice =  (bus_measure.X_Multipersonoffice-0.65)*0.42;
end if;

           
else
   if  deltaT_MultiPersonOffice<T_LowerBound then          
         LRM_TX_MultiPersonOffice = 0.04*(abs(deltaT_MultiPersonOffice)-2);
   elseif    deltaT_MultiPersonOffice>T_UpperBound then
          LRM_TX_MultiPersonOffice = 0.02*(deltaT_MultiPersonOffice-2);
   else
      LRM_TX_MultiPersonOffice =  0;
   end if;                               
  
  
  
  // open plan office
  
 if X<0.25
  then if deltaT_OpenPlanOffice<T_LowerBound then
       LRM_TX_OpenPlanOffice = 0.2*(-4*bus_measure.X_Openplanoffice+1) + 0.04*(abs(deltaT_OpenPlanOffice)-2);
       elseif deltaT_OpenPlanOffice>T_UpperBound then
           LRM_TX_OpenPlanOffice = 0.2*(-4*bus_measure.X_Openplanoffice+1) + 0.02*(abs(deltaT_OpenPlanOffice)-2);
          else
          LRM_TX_OpenPlanOffice = 0.2*(-4*bus_measure.X_Openplanoffice+1);
         end if;
         
        
       if X>0.65 then
if deltaT_OpenPlanOffice<T_LowerBou" + "nd then
  LRM_TX_OpenPlanOffice = (bus_measure.X_Openplanoffice-0.65)*0.42 + 0.04*(abs(deltaT_OpenPlanOffice)-2);
  
elseif deltaT_OpenPlanOffice>T_UpperBound then
    LRM_TX_OpenPlanOffice = (bus_measure.X_Openplanoffice-0.65)*(0.42+deltaT_OpenPlanOffice) + 0.02*(deltaT_OpenPlanOffice-2);
else
  LRM_TX_OpenPlanOffice =  (bus_measure.X_Openplanoffice-0.65)*0.42;
end if;

           
else
   if  deltaT_OpenPlanOffice<T_LowerBound then          
         LRM_TX_OpenPlanOffice = 0.04*(abs(deltaT_OpenPlanOffice)-2);
   elseif    deltaT_OpenPlanOffice>T_UpperBound then
          LRM_TX_OpenPlanOffice = 0.02*(deltaT_OpenPlanOffice-2);
   else
      LRM_TX_OpenPlanOffice =  0;
   end if;                               
  
  
  
    
   //performance reduction due to CO2 level
   //Performance reduction due to CO2 level might not be considered because there is no information about CO2 levels in the rooms
   
   //LRM_CO2_Canteen=0.0000575*C_CO2_Canteen-0.023;
   //LRM_CO2_Workshop=0.0000575*C_CO2_Workshop-0.023;
   //LRM_CO2_ConferenceRoom=0.0000575*C_CO2_ConferenceRoom-0.023;
   //LRM_CO2_MultiPersonOffice=0.0000575*C_CO2_MultiPersonOffice-0.023;
   //LRM_CO2_OpenPlanOffice=0.0000575*C_CO2_OpenPlanOffice-0.023;
   
   
   //Performance reduction due to VOC level is not considered because there is no information about VOC levels in the rooms
 
   
   //Costs due to performance reduction (if performance reduction due to CO2 levels are considered, formulas have to be edited
   
   K_LRM_Canteen=G*C_Prod/(233*8*60)*sum ((t*(1-(1-LRM_TX_Canteen))));
   K_LRM_Workshop=G*C_Prod/(233*8*60)*sum ((t*(1-(1-LRM_TX_Workshop))));
   K_LRM_ConferenceRoom=G*C_Prod/(233*8*60)*sum ((t*(1-(1-LRM_TX_ConferenceRoom))));
   K_LRM_MultiPersonOffice=G*C_Prod/(233*8*60)*sum ((t*(1-(1-LRM_TX_MultiPersonOffice))));
   K_LRM_OpenPlanOffice=G*C_Prod/(233*8*60)*sum ((t*(1-(1-LRM_TX_OpenPlanOffice))));
   
   
   //overall costs due to performance reduction
    
   K_LRM = K_LRM_Canteen + K_LRM_Workshop + K_LRM_ConferenceRoom + K_LRM_MultiPersonOffice;
   
   PerformanceReductionCost.u1=K_LRM;
   
    
end PerformanceReductionCosts;
"));
  end PerformanceReductionCosts;
public

  model LifespanReductionCosts "calculating costs of lifespan reduction due to wear as part of operating costs to evaluate the performance of a control strategy according to CCCS evaluation method"


   Real K_LDR_i;    // costs due to lifespan reduction of component i
   Real K_LDR;      // overall costs due to lifespan reduction of components
   parameter Real B=60000;  // number of cycles until minimal lifespan is reached
   Real T;    // Average lifespan in years
   parameter Real d_Op = 365; //operating time in days; assumption: whole year
   parameter Real t_cycle = 10800; // duration of one cycle (fully closed to fully opened) in seconds
   Real n;     // number of cycles during simulation period


  equation

   T = t_cycle*B/(d_Op*24*3600);







         annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      __Dymola_DymolaStoredErrors(thetext="model LifespanReductionCosts \"calculating costs of lifespan reduction due to wear as part of operating costs to evaluate the performance of a control strategy according to CCCS evaluation method\"

 
 Real K_LDR_i;                     // costs due to lifespan reduction of component i
 Real K_LDR;                       // overall costs due to lifespan reduction of components
 parameter Real B=60000;           // number of cycles until minimal lifespan is reached
 Real T;                           // average lifespan in years
 parameter Real d_Op = 365;        // operating time in days; assumption: whole year
 parameter Real t_cycle = 10800;   // duration of one cycle (fully closed to fully opened) in seconds
 Real n_i;                         // number of cycles during simulation period
 Real K_i;                         // costs for component i
     
 
equation
  
 T = t_cycle*B/(d_Op*24*3600);
  
  if n_i<B/T
  then K_LDR_i = 0
  else K_LDR_i = K_i*(n-B/T);
      
      
   K_LDR = sum (K_LDR_i);   
 
      
   annotation (Diagram(graphics={  Rectangle(
            extent={{-188,-144},{124,164}},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
                           Text(
            extent={{-106,12},{-1,52}},
            lineColor={0,0,0},
            textString=\"\"),Text(
            extent={{-106,-18},{-1,-58}},
            lineColor={0,0,0},
            textString=\"\")}),
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Text(
          lineColor={0,0,255},
          extent={{-150,110},{150,150}},
          textString=\"LifespanReductionCosts\"),
        Text(extent={{-38,-34},{38,34}}, textString=\"LifespanReductionCosts\"),
        Text(extent={{-100,52},{5,92}}, textString=\"\"),
        Text(extent={{-100,-92},{5,-52}}, textString=\"\")}));     
        
end LifespanReductionCosts;
"));
  end LifespanReductionCosts;

  model InvestmentCosts "calculating the investement costs to evaluate the performance of control strategies according to CCCS evaluation method"


   parameter Real G; //Average salary of employee p.a.
   Real E; //effort to implement control strategy in months
   parameter Real EAF; //effor adjustment factor
   parameter Real KLOC; //approximate number of lines of coe in thousands
    Real K_Strat; // costs for implementing control strategy
    Real K_Comp; //costs for components
   Real K_Inv; // overall investement costs

  equation

    E = 2.8*KLOC^1.2*EAF;



    //Investment costs for implementing control strategy

    K_Strat = E*G/12;



    //Investment costs for compopnents

    K_Comp = 0;


    //Investment costs for components are not considered. It is assuemd that all necessary components are already installed.


  //Overall investment costs

  K_Inv = K_Strat + K_Comp;



    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end InvestmentCosts;

  model RBF
    Modelica.Blocks.Sources.Constant Constant2(k=1) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-68,76})));
    Modelica.Blocks.Math.Product product annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-20,-16})));
    Modelica.Blocks.Sources.Constant Constant3(k=-1) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={78,84})));
    Modelica.Blocks.Math.Add add annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={26,-22})));
    Modelica.Blocks.Math.Division Prod annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-2,-54})));
    DiscountingFactor                                                 discountingFactor annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-2,28})));
    Modelica.Blocks.Math.Add add1 annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-26,70})));
    Modelica.Blocks.Interfaces.RealInput Rate
      annotation (Placement(transformation(extent={{-140,-46},{-100,-6}})));
    Modelica.Blocks.Interfaces.RealInput Duration_Years
      annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
    Modelica.Blocks.Interfaces.RealOutput RBF
      annotation (Placement(transformation(extent={{100,-86},{120,-66}})));
  equation
    connect(Constant3.y,add. u1)
      annotation (Line(points={{78,73},{78,-10},{32,-10}},     color={0,0,127}));
    connect(add.y, Prod.u1)
      annotation (Line(points={{26,-33},{26,-42},{4,-42}}, color={0,0,127}));
    connect(product.y, Prod.u2)
      annotation (Line(points={{-9,-16},{-9,-42},{-8,-42}}, color={0,0,127}));
    connect(discountingFactor.y,product. u1)
      annotation (Line(points={{-2,17},{-32,17},{-32,-10}}, color={0,0,127}));
    connect(discountingFactor.y,add. u2) annotation (Line(points={{-2,17},{21.5,
            17},{21.5,-10},{20,-10}},
                                  color={0,0,127}));
    connect(Constant2.y,add1. u1)
      annotation (Line(points={{-57,76},{-38,76}},color={0,0,127}));
    connect(add1.y,discountingFactor. u1)
      annotation (Line(points={{-15,70},{4,70},{4,40}},     color={0,0,127}));
    connect(Rate, product.u2) annotation (Line(points={{-120,-26},{-78,-26},{
            -78,-22},{-32,-22}}, color={0,0,127}));
    connect(Duration_Years, add1.u2) annotation (Line(points={{-120,40},{-80,40},
            {-80,64},{-38,64}}, color={0,0,127}));
    connect(Duration_Years, discountingFactor.u2)
      annotation (Line(points={{-120,40},{-8,40}}, color={0,0,127}));
    connect(Prod.y, RBF) annotation (Line(points={{-2,-65},{50,-65},{50,-76},{
            110,-76}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end RBF;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Text(
          extent={{-50,-20},{40,20}},
          lineColor={0,0,0},
          textString="CCCS")}),
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-200,-200},{
            200,200}})));
end CCCS;
