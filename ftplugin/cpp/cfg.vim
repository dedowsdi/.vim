"if exists("g:loaded_cppcfg")
  "finish
"endif
"let g:loaded_cppcfg = 1

"cpp abbrevation
:iab <buffer>  sc static_cast<>()<Left><Left><Left>
:iab <buffer>  cs const std::string
:iab <buffer>  Sup std::unique_ptr<><Left>
:iab <buffer>  I #include
:iab <buffer>  Ssp std::shared_ptr<><Left>
:iab <buffer>  Sup std::unique_ptr<><Left>
:iab <buffer>  Swp std::weak_ptr<><Left>
:iab <buffer>  Sap std::auto_ptr<><Left>
:iab <buffer>  Sfl std::forward_list<><Left>
:iab <buffer>  Sus std::unordered_set<><Left>
:iab <buffer>  Sum std::unordered_map<><Left>
:iab <buffer>  Stp template<typename T><Left>
:iab <buffer>  Cfs //------------------------------------------------------------------------------

"macro
:iab <buffer> CMd #ifdef _DEBUG<CR>#endif<esc>O
:iab <buffer> CMif #if<CR>#endif<esc>O

"boost  abbreviation
:iab <buffer> br boost::regex
:iab <buffer> brm boost::regex_match()<Left>
:iab <buffer> brs boost::regex_search()<Left>
:iab <buffer> brr boost::regex_replace()<Left>
:iab <buffer> bsm boost::smatch

"opengl abbreviation
:iab <buffer> glc  GLchar
:iab <buffer> glb  GLbyte
:iab <buffer> glub GLubyte
:iab <buffer> gls  GLshort
:iab <buffer> glus GLushort
:iab <buffer> gli  GLint
:iab <buffer> glui GLuint
:iab <buffer> glf  GLfloat
:iab <buffer> gld  GLdouble
:iab <buffer> glv  GLvoid
:iab <buffer> gle  GLenum
:iab <buffer> glz  GLsizei
:iab <buffer> gl_  GL_

"ogre related
:iab <buffer> OGS getSingleton()
:iab <buffer> O Ogre

"ogre geometry
:iab <buffer> Ogp Ogre::Plane
:iab <buffer> Ogr Ogre::Ray

"ogre hlms
:iab <buffer> Ohbb Ogre::HlmsBlendblock
:iab <buffer> Ohdb Ogre::HlmsDatablock
:iab <buffer> Ohl Ogre::HlmsListener
:iab <buffer> Ohm Ogre::HlmsManager
:iab <buffer> Ohmb Ogre::HlmsMacroblock
:iab <buffer> Ohjp Ogre::HlmsJsonPbs
:iab <buffer> Ohpdb Ogre::HlmsPbsDatablock
:iab <buffer> Ohp Ogre::HlmsPbs
:iab <buffer> Ohju Ogre::HlmsJsonUnlit
:iab <buffer> Ohudb Ogre::HlmsUnlitDatablock
:iab <buffer> Ohu Ogre::HlmsUnlit
:iab <buffer> Ohup Ogre::UnlitProperty

"ogre compositor
:iab <buffer> Occ Ogre::CompositorChannel
:iab <buffer> Occom Ogre::CompositorCommon
:iab <buffer> Occpp Ogre::CompositorPassProvider
:iab <buffer> Ocm2 Ogre::CompositorManager2
:iab <buffer> Ocn Ogre::CompositorNode
:iab <buffer> Ocnv Ogre::CompositorNodeVec
:iab <buffer> Ocnd Ogre::CompositorNodeDef
:iab <buffer> Ocp Ogre::CompositorPass
:iab <buffer> Ocpc Ogre::PassClear
:iab <buffer> Ocpd Ogre::CompositorPassDef
:iab <buffer> Ocpdc Ogre::PassDepthCopy
:iab <buffer> Ocpm Ogre::PassMipmap
:iab <buffer> Ocpq Ogre::PassQuad
:iab <buffer> Ocps Ogre::PassScene
:iab <buffer> Ocpsten Ogre::PassStencil
:iab <buffer> Ocpu Ogre::PassUav
:iab <buffer> Ocsn Ogre::CompositorShadowNode
:iab <buffer> Ocsnd Ogre::CompositorShadowNodeDef
:iab <buffer> Octd Ogre::TextureDefinition
:iab <buffer> Ocw Ogre::CompositorWorkspace
:iab <buffer> Ocwd Ogre::CompositorWorkspaceDef
:iab <buffer> Ocwl Ogre::CompositorWorkspaceListener

"ogre math
:iab <buffer> Om Ogre::Math
:iab <buffer> Omd Ogre::Degree
:iab <buffer> Omm3 Ogre::Matrix3
:iab <buffer> Omm4 Ogre::Matrix4
:iab <buffer> Omq Ogre::Quaternion
:iab <buffer> Omr Ogre::Real
:iab <buffer> Omrad Ogre::Radian
:iab <buffer> Omv2 Ogre::Vector2
:iab <buffer> Omv3 Ogre::Vector3
:iab <buffer> Omv4 Ogre::Vector4

"ogre node
:iab <buffer> Onb Ogre::Bone
:iab <buffer> Onn Ogre::Node
:iab <buffer> Onsn Ogre::SceneNode
:iab <buffer> Ontp Ogre::TagPoint
:iab <buffer> Onnvi Ogre::Node::NodeVecIterator

"ogre movable
:iab <buffer> Ooc Ogre::Camera
:iab <buffer> Ooi Ogre::Item
:iab <buffer> Ool Ogre::Light
:iab <buffer> Ooman Ogre::ManualObject
:iab <buffer> Oomo Ogre::MovableObject
:iab <buffer> Oop Ogre::Particle;
:iab <buffer> Oopa Ogre::ParticleAffector
:iab <buffer> Oope Ogre::ParticleEmitter
:iab <buffer> Oops Ogre::ParticleSystem
:iab <buffer> Oopsm Ogre::ParticleSystemManager
:iab <buffer> Oopsr Ogre::ParticleSystemRenderer

"ogre render
:iab <buffer> Ort Ogre::RenderTarget
:iab <buffer> Ortex Ogre::RenderTexture
:iab <buffer> Orq Ogre::RenderQueue
:iab <buffer> Ors Ogre::RenderSystem
:iab <buffer> Orw Ogre::RenderWindow

"ogre string related
:iab <buffer> Os Ogre::String
:iab <buffer> Osc Ogre::StringConverter
:iab <buffer> Osu Ogre::StringUtil
:iab <buffer> Ot Ogre::Texture

"ogre singleton
:iab <buffer> Osgam Ogre::ArchiveManager::getSingleton()
:iab <buffer> Osgcm Ogre::ControllerManager::getSingleton()
:iab <buffer> Osgdl DynLibManager::getSingleton()
:iab <buffer> Osgets ExternalTextureSourceManager::getSingleton()
:iab <buffer> Osggp GpuProgramManager::getSingleton()
:iab <buffer> Osghlgp HighLevelGpuProgramManager::getSingleton()
:iab <buffer> Osglm Ogre::LogManager::getSingleton()
:iab <buffer> Osgls LodStrategyManager::getSingleton()
:iab <buffer> Osgmm MeshManager::getSingleton()
:iab <buffer> Osgmma MaterialManager::getSingleton()
:iab <buffer> Osgpsm Ogre::ParticleSystemManager::getSingleton()
:iab <buffer> Osgr Ogre::Root::getSingleton()
:iab <buffer> Osgrg ResourceGroupManager::getSingleton()
:iab <buffer> Osgrm ResourceManager::getSingleton()
:iab <buffer> Osgrsc RenderSystemCapabilitiesManager::getSingleton()
:iab <buffer> Osgs SkeletonManager::getSingleton()
:iab <buffer> Osgst ShadowTextureManager::getSingleton()
:iab <buffer> Osgt TextureManager::getSingleton()

"ogre manager
:iab <buffer> Omga Ogre::ArchiveManager
:iab <buffer> Omgam Ogre::ArrayMemoryManager
:iab <buffer> Omgbm Ogre::BoneMemoryManager
:iab <buffer> Omgc Ogre::ControllerManager
:iab <buffer> Omgc2 Ogre::CompositorManager2
:iab <buffer> Omgdl Ogre::DynLibManager
:iab <buffer> Omgets Ogre::ExternalTextureSourceManager
:iab <buffer> Omggp Ogre::GpuProgramManager
:iab <buffer> Omgh Ogre::HlmsManager
:iab <buffer> Omghlgp Ogre::HighLevelGpuProgramManager
:iab <buffer> Omght Ogre::HlmsTextureManager
:iab <buffer> Omgi Ogre::InstanceManager
:iab <buffer> Omgl Ogre::LogManager
:iab <buffer> Omgls Ogre::LodStrategyManager
:iab <buffer> Omgm Ogre::MeshManager
:iab <buffer> Omgmat Ogre::MaterialManager
:iab <buffer> Omgmem Ogre::MemoryManager
:iab <buffer> Omgnm Ogre::NodeMemoryManager
:iab <buffer> Omgom Ogre::ObjectMemoryManager
:iab <buffer> Omgos Ogre::OldSkeletonManager
:iab <buffer> Omgps Ogre::ParticleSystemManager
:iab <buffer> Omgr Ogre::ResourceManager
:iab <buffer> Omgrg Ogre::ResourceGroupManager
:iab <buffer> Omgrsc Ogre::RenderSystemCapabilitiesManager
:iab <buffer> Omgs Ogre::SceneManager
:iab <buffer> Omgsc Ogre::ScriptCompilerManager
:iab <buffer> Omgske Ogre::SkeletonManager
:iab <buffer> Omgst Ogre::ShadowTextureManager
:iab <buffer> Omgt Ogre::TextureManager
:iab <buffer> Omgv Ogre::VaoManager

:iab <buffer> Oecbt Ogre::ColourBufferType
:iab <buffer> Oecf Ogre::CompareFunction
:iab <buffer> Oecm Ogre::CullingMode
:iab <buffer> Oecr Ogre::ClipResult
:iab <buffer> Oefbt Ogre::FrameBufferType
:iab <buffer> Oefm Ogre::FogMode
:iab <buffer> Oefo Ogre::FilterOptions
:iab <buffer> Oeft Ogre::FilterType
:iab <buffer> Oeimf Ogre::InstanceManagerFlags
:iab <buffer> Oepm Ogre::PolygonMode
:iab <buffer> Oesm Ogre::SortMode
:iab <buffer> Oesmmt Ogre::SceneMemoryMgrTypes
:iab <buffer> Oesmt Ogre::StereoModeType
:iab <buffer> Oeso Ogre::ShadeOptions
:iab <buffer> Oeso Ogre::StencilOperation
:iab <buffer> Oest Ogre::ShaderType
:iab <buffer> Oetfo Ogre::TextureFilterOptions
:iab <buffer> Oetvc Ogre::TrackVertexColourEnum
:iab <buffer> Oevp Ogre::VertexPass
:iab <buffer> Oewt Ogre::WaveformType
:iab <buffer> Oellt Ogre::Light::LightTypes
:iab <buffer> Oents Ogre::Node::TransformSpace

"mygui
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

"sdl2
:iab <buffer> S SDL_
:iab <buffer> Sk SDLK_

"cscope-----------------------------------------------------
"if has("cscope")
  "set csprg=/usr/bin/cscope
  ""search cscope databases before tag files
  "set csto=0
  ""use cstag instead of tag
  "set cst
  ""print message when adding a cscope database
  "set nocsverb
  ""use quickfix
  "set cscopequickfix=s-,c-,d-,i-,t-,e-
  "" add any database in current directory
  "if filereadable("cscope.out")
    "cs add cscope.out
    "" else add database pointed to by environment
  "elseif $CSCOPE_DB != ""
    "cs add $CSCOPE_DB
  "endif
  "set csverb
"endif

"0 or s: Find this C symbol
"1 or g: Find this definition
"2 or d: Find functions called by this function
"3 or c: Find functions calling this function
"4 or t: Find this text string
"6 or e: Find this egrep pattern
"7 or f: Find this file
"8 or i: Find files #including this file
"nnoremap <Leader><Leader>s :lcs find s <C-R>=expand("<cword>")<CR><CR>
"nnoremap <Leader><Leader>g :lcs find g <C-R>=expand("<cword>")<CR><CR>
"nnoremap <Leader><Leader>c :lcs find c <C-R>=expand("<cword>")<CR><CR>
"nnoremap <Leader><Leader>t :lcs find t <C-R>=expand("<cword>")<CR><CR>
"nnoremap <Leader><Leader>e :lcs find e <C-R>=expand("<cword>")<CR><CR>
"nnoremap <Leader><Leader>f :lcs find f <C-R>=expand("<cfile>")<CR><CR>
"nnoremap <Leader><Leader>i :lcs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
"nnoremap <Leader><Leader>d :lcs find d <C-R>=expand("<cword>")<CR><CR>
"command! -nargs=0  Cs :cs find s <C-R>=expand("<cword>")<CR><CR>
"command! -nargs=0  Cg :cs find g <C-R>=expand("<cword>")<CR><CR>
"command! -nargs=0  Cc :cs find c <C-R>=expand("<cword>")<CR><CR>
"command! -nargs=0  Ct :cs find t <C-R>=expand("<cword>")<CR><CR>
"command! -nargs=0  Ce :cs find e <C-R>=expand("<cword>")<CR><CR>
"command! -nargs=0  Cf :cs find f <C-R>=expand("<cfile>")<CR><CR>
"command! -nargs=0  Ci :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
"command! -nargs=0  Cd :cs find d <C-R>=expand("<cword>")<CR><CR>

"check ctags --list-kind=c++ for detail
"Most of the time i need only functin declaration tags, i don't need function
"definition tags.
"command! -nargs=0 Cut :!ctags --c++-kinds=+p-f include/* src/*
