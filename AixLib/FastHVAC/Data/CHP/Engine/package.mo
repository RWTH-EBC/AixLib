within AixLib.FastHVAC.Data.CHP;
package Engine
      extends Modelica.Icons.Package;

  record AisinSeiki

   extends Engine.BaseDataDefinition(
      a_0=-0.0315,
      a_1=-0.0064,
      a_2=0.0788,
      a_3=-1.0624,
      a_4=0.4869,
      a_5=0.0000,
      a_6=-0.0000,
      b_0=0.7111,
      b_1=0.0065,
      b_2=-0.0811,
      b_3=-4.8054,
      b_4=2.2644,
      b_5=-0.0000,
      b_6=0.0001,
      P_elRated=5580,
      tauQ_th_start=857.84,
      tauQ_th_stop = 90,
      tauP_el=5.41,
      dotm_max=0.18,
      dotm_min=0.18,
      dotQ_thRated = 10983,
      dotE_fuelRated = 21285,
      P_elStop = -190,
      P_elStart = -190,
      P_elStandby = -90);
  end AisinSeiki;

  record BaseDataDefinition "Basic Mikro_KWK Data"
    extends
          Modelica.Icons.Record;

    import SI = Modelica.SIunits;
    import SIconv = Modelica.SIunits.Conversions.NonSIunits;
    Modelica.SIunits.MassFlowRate dotm_max "maximum mass flow rate";
    Modelica.SIunits.MassFlowRate dotm_min "minimum mass flow rate";
    parameter SI.Power P_elRated "rated electrical power (unit=W)";
    parameter Modelica.SIunits.Time tauQ_th_start
    "time constant for thermal start behavior (unit=sec) ";
    parameter Modelica.SIunits.Time tauQ_th_stop
    "time constant for stop behaviour (unit=sec)";
    parameter Modelica.SIunits.Time tauP_el
    "time constant electrical power start behavior (unit=sec)";
    parameter SI.Power dotQ_thRated "rated thermal power (unit=W)";
    parameter SI.Power dotE_fuelRated "rated fuel power (unit=W)";
    parameter Modelica.SIunits.Power P_elStandby
      "electrical consumption in standby mode";
    parameter Modelica.SIunits.Power P_elStop
      "electrical consumption during shutdown mode";
    parameter Modelica.SIunits.Power P_elStart
      "electrical consumption during startup";
    parameter Real a_0;
    parameter Real a_1;
    parameter Real a_2;
    parameter Real a_3;
    parameter Real a_4;
    parameter Real a_5;
    parameter Real a_6;
    parameter Real b_0;
    parameter Real b_1;
    parameter Real b_2;
    parameter Real b_3;
    parameter Real b_4;
    parameter Real b_5;
    parameter Real b_6;

  end BaseDataDefinition;

  record Dachs
    extends Engine.BaseDataDefinition(
      a_0=0.1710,
      a_1=0.0080,
      a_2=0.0199,
      a_3=-4.6258,
      a_4=0.3781,
      a_5=-0.0000,
      a_6=0.0000,
      b_0=1.4312,
      b_1=-0.0232,
      b_2=-0.0839,
      b_3=2.2559,
      b_4=0.7906,
      b_5=0.0000,
      b_6=-0.0031,
      P_elRated=5500,
      tauQ_th_start=147.05,
      tauQ_th_stop = 90,
      tauP_el=73.52,
      dotm_max=0.27778,
      dotm_min=0.27778,
      dotQ_thRated = 12500,
      dotE_fuelRated = 20600,
      P_elStop = -190,
      P_elStart = -190,
      P_elStandby = -90);
      // the last three parameters where only available for the AisinSeiki ICE, so they are just copied!
  end Dachs;

  record Ecopower_1_0

    extends Engine.BaseDataDefinition(
      a_0=0.263,
      a_1=0,
      a_2=0,
      a_3=-0.0000,
      a_4=0.0000,
      a_5=-0.0000,
      a_6=0.0000,
      b_0=0.657,
      b_1=0,
      b_2=0,
      b_3=-0.0000,
      b_4=0.0000,
      b_5=-0.0000,
      b_6=-0.0000,
      P_elRated=1000,
      tauQ_th_start=882.35,
      tauQ_th_stop = 90,
      tauP_el=73.52,
      dotm_max=0.06,
      dotm_min=0.06,
      dotQ_thRated = 1641,
      dotE_fuelRated = 3802,
      P_elStop = -190,
      P_elStart = -190,
      P_elStandby = -90);
      // the last three parameters where only available for the AisinSeiki ICE, so they are just copied!
  end Ecopower_1_0;

  record Ecopower_3_0

    extends Engine.BaseDataDefinition(
      a_0=0.25,
      a_1=0,
      a_2=0,
      a_3=-0.0000,
      a_4=0.0000,
      a_5=-0.0000,
      a_6=0.0000,
      b_0=0.65,
      b_1=0,
      b_2=0,
      b_3=-0.0000,
      b_4=0.0000,
      b_5=-0.0000,
      b_6=-0.0000,
      P_elRated=3000,
      tauQ_th_start=882.35,
      tauQ_th_stop = 90,
      tauP_el=73.52,
      dotm_max=0.06,
      dotm_min=0.06,
      dotQ_thRated = 5070,
      dotE_fuelRated = 12000,
      P_elStop = -190,
      P_elStart = -190,
      P_elStandby = -90);
      // the last three parameters where only available for the AisinSeiki ICE, so they are just copied!
  end Ecopower_3_0;

  record Ecopower

    extends Engine.BaseDataDefinition(
      a_0=-0.0417,
      a_1=0.0117,
      a_2=0.0104,
      a_3=-0.0000,
      a_4=0.0000,
      a_5=-0.0000,
      a_6=0.0000,
      b_0=-2.0000,
      b_1=0.0905,
      b_2=0.1875,
      b_3=-0.0000,
      b_4=0.0000,
      b_5=-0.0000,
      b_6=-0.0000,
      P_elRated=4460,
      tauQ_th_start=882.35,
      tauQ_th_stop = 90,
      tauP_el=73.52,
      dotm_max=0.287,
      dotm_min=0.073,
      dotQ_thRated = 7609,
      dotE_fuelRated = 18785,
      P_elStop = -190,
      P_elStart = -190,
      P_elStandby = -90);
      // the last three parameters where only available for the AisinSeiki ICE, so they are just copied!
  end Ecopower;

  record Kirsch

    extends Engine.BaseDataDefinition(
      a_0=0.117,
      a_1=0.0001,
      a_2=0.0286,
      a_3=0,
      a_4=0,
      a_5=0,
      a_6=0.0002,
      b_0=0.7304,
      b_1=-0.0029,
      b_2=0.0617,
      b_3=6.2774,
      b_4=-1.0263,
      b_5=-1.9368*10^(-6),
      b_6=-0.0035,
      P_elRated=3900,
      tauQ_th_start=588.23,
      tauQ_th_stop = 90,
      tauP_el=275.73,
      dotm_max=0.1236,
      dotm_min=0.0819,
      dotQ_thRated = 9275,
      dotE_fuelRated = 16211,
      P_elStop = -190,
      P_elStart = -190,
      P_elStandby = -90);
      // the last three parameters where only available for the AisinSeiki ICE, so they are just copied!
  end Kirsch;

  record Xrgi

    extends Engine.BaseDataDefinition(
      a_0=-1.3036,
      a_1=0.0009,
      a_2=0.0982,
      a_3=-0.0000,
      a_4=0.0000,
      a_5=-0.0000,
      a_6=0.0000,
      b_0=0.1822,
      b_1=0.0011,
      b_2=0.0123,
      b_3=0.6963,
      b_4=-0.5130,
      b_5=-0.0000,
      b_6=0.0011,
      P_elRated=14300,
      tauQ_th_start=661.76,
      tauQ_th_stop = 90,
      tauP_el=102.94,
      dotm_max=0.3509,
      dotm_min=0.0586,
      dotQ_thRated = 17044,
      dotE_fuelRated = 50228,
      P_elStop = -190,
      P_elStart = -190,
      P_elStandby = -90);
      // the last three parameters where only available for the AisinSeiki ICE, so they are just copied!
  end Xrgi;
end Engine;
