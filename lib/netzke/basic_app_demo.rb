module Netzke
  class BasicAppDemo < BasicApp
    
    #
    # Specify available "actions" for the application widget
    #
    def actions
      { 
        :clerks => {:text => "Clerks", :fn => "loadWidgetByAction"},
        :bosses => {:text => "Bosses", :fn => "loadWidgetByAction"},
        
        # Only allow administrative actions when user is logged in
        :users => {:text => "Users", :fn => "loadWidgetByAction", :disabled => Netzke::Base.user.nil?}
      }
    end
    
    #
    # Specify the menus (simply specifying available action names)
    #
    def menu
      [{
        :text => "Go to",
        :menu => %w{ clerks bosses users }
      }]
    end
    
    #
    # Here are the widgets that our application will be able to load dynamically (see the demo for Netzke::GridPanel)
    #
    def initial_late_aggregatees
      {
        :clerks => {
          :widget_class_name => "BorderLayoutPanel",
          :ext_config => {
            :title => false
          },
          :regions => {
            :center => {
              :widget_class_name => "GridPanel", 
              :data_class_name => "Clerk", 
              :ext_config => {
                :title => 'Clerks',
                :rows_per_page => 20,
                :config_tool => true
              }
            },
            :south => {
              :widget_class_name => "Panel",
              :region_config => {
                :height => 150,
                :split => true
              },
              :ext_config => {
                :title => false,
                :body_style => "padding: 5px",
                :html => %Q{
What you see is a BorderLayoutPanel-based compound widget, containing a GridPanel interfacing the Clerks data, and a Panel with a little explanation (the one you are reading). <br>What is here to play with: <br>1) Do some on-the-fly configuration of the grid - move around or resize its columns, change something in the columns configuration panel (click the tool-button in the up-right corner), and then log out and in again - you'll see that your changes got stored; <br>2) Change the size of this (south) region - it'll get stored for you as well, by to the BorderLayoutPanel widget. <br>The same explanation naturally applies to the <a href="#bosses">bosses</a> view.
}
              }
            }
          }
        },

        :bosses => {
          :widget_class_name => "BorderLayoutPanel",
          :ext_config => {
            :title => false
          },
          :regions => {
            :center => {
              :widget_class_name => "GridPanel", 
              :data_class_name => "Boss", 
              :ext_config => {
                :title => "Bosses",
                :rows_per_page => 20,
                :config_tool => true
              }
            },
            :south => {
              :widget_class_name => "Panel",
              :region_config => {
                :height => 50,
                :split => true
              },
              :ext_config => {
                :title => false,
                :body_style => "padding: 5px",
                :html => %Q{See the explanations for the <a href="#clerks">clerks</a> view.}
              }
            }
          }
        },

        :users => {
          :widget_class_name => "BorderLayoutPanel",
          :ext_config => {
            :title => 'User manager'
          },
          :regions => {
            :center => {
              :widget_class_name => "UserManager"
            },
            :south => {
              :widget_class_name => "Panel",
              :region_config => {
                :height => 150,
                :split => true
              },
              :ext_config => {
                :title => false,
                :auto_scroll => true,
                :body_style => "padding: 5px",
                :html => %Q{Here you have a widget called UserManager, which extends the compound TableEditor widget (part of netzke-pasepack), which in its turn consists of a GridPanel and a FormPanel working together.<br>Adding new users is done by filling out the form (see Rails' validations kicking in).<br>Layouts for grid and form are configured separately (by pressing the configuration tool-button on the top-right corner of each widget). See how {"inputType":"password"} is specified in the "Ext config" column for the form - this is how you get the password masked. This way you may specify any additional configuration parameters understood by any Ext.form.Field-derived component. Later the FieldConfigurator will probably provide a GUI for editing this extra configuration, but for now the JSON code can only be edited by hand. But! If you add a column named "input_type" to netzke_form_panel_fields table, this configuration option will get magically over-taken by that column, instead of being present in "Ext config" (this is true for any other configuration option for Ext.form.Field, of course)}
              }
            }
          }
        }
      }
    end
  end
end