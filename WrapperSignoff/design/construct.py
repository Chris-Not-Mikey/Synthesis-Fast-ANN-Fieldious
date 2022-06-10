#! /usr/bin/env python
#=========================================================================
# construct.py
#=========================================================================
# Signoff flow for user_project_wrapper
#
# Author      : Priyanka Raina
# Date        : May 20, 2022

import os
import sys

from mflowgen.components import Graph, Step

def construct():

  g = Graph()

  #-----------------------------------------------------------------------
  # Parameters
  #-----------------------------------------------------------------------
  
  adk_name = 'skywater-130nm-adk'
  adk_view = 'view-standard'

  parameters = {
    'construct_path' : __file__,
    'design_name'    : 'GcdUnit',
    'clock_period'   : 10.0,
    'adk'            : adk_name,
    'adk_view'       : adk_view,
    'topographical'  : True,
    'lvs_extra_spice_include' : 'inputs/adk/*.spi'
  }

  #-----------------------------------------------------------------------
  # Create nodes
  #-----------------------------------------------------------------------

  this_dir = os.path.dirname( os.path.abspath( __file__ ) )

  # ADK step

  g.set_adk( adk_name )
  adk = g.get_adk_step()

  # Custom steps

  adk_closed      = Step( this_dir + '/sky130-closed-adk'               )
  user_project_wrapper = Step( this_dir + '/user_project_wrapper'       )
  magic_drc       = Step( this_dir + '/open-magic-drc'                  )
  magic_gds2spice = Step( this_dir + '/open-magic-gds2spice'            )
  netgen_lvs_gds  = Step( this_dir + '/netgen-lvs-gds'                  )
  netgen_lvs_gds_device = Step( this_dir + '/netgen-lvs-gds-device'     )
  magic_antenna   = Step( this_dir + '/open-magic-antenna'              )
  calibre_lvs_on_magic_extraction = Step( this_dir + '/mentor-calibre-comparison')
  calibre_drc     = Step( this_dir + '/mentor-calibre-drc'              )

  # Default steps

  info            = Step( 'info',                          default=True )
  calibre_lvs     = Step( this_dir + '/mentor-calibre-lvs'              )
  
  #-----------------------------------------------------------------------
  # Graph -- Add nodes
  #-----------------------------------------------------------------------

  g.add_step( info            )
  g.add_step( user_project_wrapper )
  g.add_step( magic_drc       )
  g.add_step( magic_antenna   )
  g.add_step( magic_gds2spice )
  g.add_step( netgen_lvs_gds  )
  g.add_step( netgen_lvs_gds_device )
  g.add_step( calibre_lvs_on_magic_extraction )
  g.add_step( calibre_drc     )
  g.add_step( calibre_lvs     )
  g.add_step( adk_closed      )

  #-----------------------------------------------------------------------
  # Graph -- Add edges
  #-----------------------------------------------------------------------
  
  magic_drc.extend_inputs(['sky130_sram_1kbyte_1rw1r_32x256_8.lef'])  
  magic_drc.extend_inputs(['sky130_sram_2kbyte_1rw1r_32x512_8.lef'])  
  magic_gds2spice.extend_inputs(['sky130_sram_1kbyte_1rw1r_32x256_8.lef'])  
  magic_gds2spice.extend_inputs(['sky130_sram_2kbyte_1rw1r_32x512_8.lef'])  

  # Connect by name
  g.connect_by_name( adk,             adk_closed      )
  g.connect_by_name( adk,             magic_drc       )
  g.connect_by_name( adk,             magic_antenna   )
  g.connect_by_name( adk,             magic_gds2spice )
  g.connect_by_name( adk,             netgen_lvs_gds  )
  g.connect_by_name( adk,             netgen_lvs_gds_device  )
  g.connect_by_name( adk,             calibre_lvs_on_magic_extraction     )
  g.connect_by_name( adk_closed,      calibre_drc     )
  g.connect_by_name( adk_closed,      calibre_lvs     )

  # DRC and antenna checks using magic
  g.connect_by_name( user_project_wrapper,         magic_drc       )
  g.connect_by_name( user_project_wrapper,         magic_antenna   )

  # DRC using calibre
  g.connect_by_name( user_project_wrapper,         calibre_drc     )
  
  # LVS on GDS using netgen
  g.connect_by_name( user_project_wrapper,         magic_gds2spice )
  g.connect_by_name( user_project_wrapper,         netgen_lvs_gds  )
  g.connect_by_name( user_project_wrapper,         netgen_lvs_gds_device  )
  g.connect_by_name( magic_gds2spice, netgen_lvs_gds  )
  g.connect_by_name( magic_gds2spice, netgen_lvs_gds_device  )

  # LVS on GDS using calibre but with magic extraction
  g.connect_by_name( user_project_wrapper, calibre_lvs_on_magic_extraction )
  g.connect_by_name( magic_gds2spice, calibre_lvs_on_magic_extraction )

  # LVS on GDS using only calibre
  g.connect_by_name( user_project_wrapper,         calibre_lvs     )
 
  #-----------------------------------------------------------------------
  # Parameterize
  #-----------------------------------------------------------------------

  g.update_params( parameters )

  return g

if __name__ == '__main__':
  g = construct()
  g.plot()
