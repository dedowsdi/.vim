function! misc#mygui#loadAbbreviation()
  :iab <buffer> M MyGUI

  "mygui widget
  :iab <buffer> Mwb MyGUI::Button
  :iab <buffer> Mwc MyGUI::Canvas
  :iab <buffer> Mwcb MyGUI::ComboBox
  :iab <buffer> Mwddc MyGUI::DDContainer
  :iab <buffer> Mweb MyGUI::EditBox
  :iab <buffer> Mwib MyGUI::ItemBox
  :iab <buffer> Mwibox MyGUI::ImageBox
  :iab <buffer> Mwlb MyGUI::ListBox
  :iab <buffer> Mwmb MyGUI::MenuBar
  :iab <buffer> Mwmc MyGUI::MenuControl
  :iab <buffer> Mwmi MyGUI::MenuItem
  :iab <buffer> Mwmlb MyGUI::MultiListBox
  :iab <buffer> Mwmli MyGUI::MultiListItem
  :iab <buffer> Mwpb MyGUI::ProgressBar
  :iab <buffer> Mwpm MyGUI::PopupMenu
  :iab <buffer> Mwsb MyGUI::ScrollBar
  :iab <buffer> Mwsv MyGUI::ScrollView
  :iab <buffer> Mwtb MyGUI::TextBox
  :iab <buffer> Mwtc MyGUI::TabControl
  :iab <buffer> Mwti MyGUI::TabItem
  :iab <buffer> Mww MyGUI::Widget
  :iab <buffer> Mwwin MyGUI::Window

  "mygui manager
  :iab <buffer> Mmgc MyGUI::ControllerManager
  :iab <buffer> Mmgcb MyGUI::ClipboardManager
  :iab <buffer> Mmgdl MyGUI::DynLibManager
  :iab <buffer> Mmgf MyGUI::FontManager
  :iab <buffer> Mmgfac MyGUI::FactoryManager
  :iab <buffer> Mmgi MyGUI::InputManager
  :iab <buffer> Mmgl MyGUI::LogManager
  :iab <buffer> Mmglan MyGUI::LanguageManager
  :iab <buffer> Mmglaye MyGUI::LayerManager
  :iab <buffer> Mmglayo MyGUI::LayoutManager
  :iab <buffer> Mmgplu MyGUI::PluginManager
  :iab <buffer> Mmgpoi MyGUI::PointerManager
  :iab <buffer> Mmgren MyGUI::RenderManager
  :iab <buffer> Mmgres MyGUI::ResourceManager
  :iab <buffer> Mmgs MyGUI::SkinManager
  :iab <buffer> Mmgsw MyGUI::SubWidgetManager
  :iab <buffer> Mmgtt MyGUI::ToolTipManager
  :iab <buffer> Mmgw MyGUI::WidgetManager

  "mygui singleton
  :iab <buffer> Msgcm MyGUI::ControllerManager::getSingleton()
  :iab <buffer> Msgcbm MyGUI::ClipboardManager::getSingleton()
  :iab <buffer> Msgdlm MyGUI::DynLibManager::getSingleton()
  :iab <buffer> Msgfm MyGUI::FontManager::getSingleton()
  :iab <buffer> Msgfacm MyGUI::FactoryManager::getSingleton()
  :iab <buffer> Msgim MyGUI::InputManager::getSingleton()
  :iab <buffer> Msglm MyGUI::LogManager::getSingleton()
  :iab <buffer> Msglanm MyGUI::LanguageManager::getSingleton()
  :iab <buffer> Msglayem MyGUI::LayerManager::getSingleton()
  :iab <buffer> Msglayom MyGUI::LayoutManager::getSingleton()
  :iab <buffer> Msgplum MyGUI::PluginManager::getSingleton()
  :iab <buffer> Msgpoim MyGUI::PointerManager::getSingleton()
  :iab <buffer> Msgrenm MyGUI::RenderManager::getSingleton()
  :iab <buffer> Msgresm MyGUI::ResourceManager::getSingleton()
  :iab <buffer> Msgsm MyGUI::SkinManager::getSingleton()
  :iab <buffer> Msgswm MyGUI::SubWidgetManager::getSingleton()
  :iab <buffer> Msgttm MyGUI::ToolTipManager::getSingleton()
  :iab <buffer> Msgwm MyGUI::WidgetManager::getSingleton()
endfunction
