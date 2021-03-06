/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

#include "xsi.h"

struct XSI_INFO xsi_info;



int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    work_m_00000000000409427660_3210399350_init();
    work_m_00000000004140189628_4024466370_init();
    work_m_00000000000568251566_0103510313_init();
    work_m_00000000001789422985_0345418465_init();
    work_m_00000000002933122333_2520395732_init();
    work_m_00000000002292405306_4094291831_init();
    work_m_00000000001877015391_1733832700_init();
    work_m_00000000002825245677_2725559894_init();
    work_m_00000000000670688500_3180292034_init();
    work_m_00000000002380648422_3258266500_init();
    work_m_00000000001449031586_2828040072_init();
    work_m_00000000003696835086_3913188552_init();
    work_m_00000000002191297720_0967167703_init();
    work_m_00000000000202403609_3823007873_init();
    work_m_00000000002591613811_3115858369_init();
    work_m_00000000004134447467_2073120511_init();


    xsi_register_tops("work_m_00000000002591613811_3115858369");
    xsi_register_tops("work_m_00000000004134447467_2073120511");


    return xsi_run_simulation(argc, argv);

}
