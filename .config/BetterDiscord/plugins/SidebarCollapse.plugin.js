/**
 * @name SidebarCollapse
 * @author Core
 * @authorId 546426958465073163
 * @version 1.0.0
 * @description Plugin that collapses the sidebar when it is not being hovered.
 */

module.exports = (_ => {
    const config = {
        "info": {
            "name": "SidebarCollapse",
            "version": "1.0.0",
            "author": "Core",
            "description": "Plugin that collapses the sidebar when it is not being hovered."
        }
    };

    return !window.BDFDB_Global || (!window.BDFDB_Global.loaded && !window.BDFDB_Global.started) ? class {
        getName() { return config.info.name; }
        getAuthor() { return config.info.author; }
        getVersion() { return config.info.version; }
        getDescription() { return `The Library Plugin needed for ${config.info.name} is missing. Open the Plugin Settings to download it. \n\n${config.info.description}`; }

        load() {
            if (!window.BDFDB_Global || !Array.isArray(window.BDFDB_Global.pluginQueue)) window.BDFDB_Global = Object.assign({}, window.BDFDB_Global, { pluginQueue: [] });
            if (!window.BDFDB_Global.downloadModal) {
                window.BDFDB_Global.downloadModal = true;
                BdApi.showConfirmationModal("Library Missing", `The Library Plugin needed for ${config.info.name} is missing. Please click "Download Now" to install it.`, {
                    confirmText: "Download Now",
                    cancelText: "Cancel",
                    onCancel: _ => { delete window.BDFDB_Global.downloadModal; },
                    onConfirm: _ => {
                        delete window.BDFDB_Global.downloadModal;
                    }
                });
            }
            if (!window.BDFDB_Global.pluginQueue.includes(config.info.name)) window.BDFDB_Global.pluginQueue.push(config.info.name);
        }
        start() { this.load(); }
        stop() { }
    } : (([Plugin, BDFDB]) => {
        return class SidebarCollapse extends Plugin {

            getSettingsPanel (collapseStates = {}) {
				return BDFDB.PluginUtils.createSettingsPanel(this, {
					collapseStates: collapseStates,
					children: _ => {
                        let SettingsItems = []

                        for (const collapse in this.defaults) {
                            SettingsItems.push(BDFDB.ReactUtils.createElement(BDFDB.LibraryComponents.CollapseContainer, {
                                title: this.defaults[collapse].title,
                                collapseStates: collapseStates,
                                children: Object.keys(this.defaults[collapse]).map(key => this.defaults[collapse][key].type === 'number' ? BDFDB.ReactUtils.createElement(BDFDB.LibraryComponents.SettingsSaveItem, {
                                    type: "TextInput",
                                    childProps: {
                                        type: "number"
                                    },
                                    plugin: this,
                                    key: key,
                                    keys: [collapse, key],
                                    label: this.defaults[collapse][key].description,
                                    value: this.settings[collapse][key]
                                }) : this.defaults[collapse][key].type === 'switch' ? BDFDB.ReactUtils.createElement(BDFDB.LibraryComponents.SettingsSaveItem, {
                                    type: "Switch",
                                    plugin: this,
                                    key: key,
                                    keys: [collapse, key],
                                    label: this.defaults[collapse][key].description,
                                    value: this.settings[collapse][key]
                                }) : null)
                            }))
                        }


                        return SettingsItems;
					}
				});
			}
			onSettingsClosed () {
				if (this.SettingsUpdated) {
					delete this.SettingsUpdated;
					this.forceUpdateAll();
				}
			}
			forceUpdateAll () {
				BDFDB.PatchUtils.forceAllUpdates(this);
				BDFDB.MessageUtils.rerenderAll();

                console.log('its erroring on rm')
                if (!this.settings.hover.dmsOpen) {
                    this.removeListeners('.privateChannels-oVe7HL')
                } else if (!this.settings.hover.channelOpen) {
                    this.removeListeners('.container-1NXEtd')
                } else {
                    console.log('its erroring on add')
                    this.createListeners()
                }
                console.log('its erroring on stylesheet')
				this.applyStylesheet()
			}

            // begin of main functions
            stylesheet = null;
            applyStylesheet() {
                this.stylesheet.innerHTML = `
                .guilds-2JjMmN[aria-label="Servers sidebar"]::after {
                    content: "";
                    width: 1px;
                    position: absolute;
                    left: 0;
                    top: 0;
                    height: 100%;
                    background-color: #191919;
                }
                
                .guilds-2JjMmN[aria-label="Servers sidebar"] {
                    width: ${this.settings.sidebar.sidebarWidth ?? this.defaults.sidebar.sidebarWidth}px;
                    transition: all ${this.settings.sidebar.collapseTimer ?? this.defaults.sidebar.collapseTimer}s ease-out;
                }
                `;
            }

            listenerFunctions = {
                lastLeft: '',
                activeListeners: {mouseenter: [], mouseleave: []},
                mouseenter: (e, force=false) => {

                    const divs = document.getElementsByClassName("guilds-2JjMmN")
                    for (let i = 0; i < divs.length; i++) {
                        divs[i].style.width = `${this.settings.sidebar.sidebarWidthOpen}px`;
                    }

                    if (this.settings.sidebar.sidebarWidth > 5) {
                        const divs = document.getElementsByClassName("pill-2RsI5Q")
                        for (let i = 0; i < divs.length; i++) {
                            divs[i].style.visibility = 'initial';
                        }
                    }

                    if (e) {
                        this.lastLeft = e.target;
                    }
                },
                mouseleave: (e) => {
                    if (document.querySelector('#guild-context') || this.listenerFunctions.lastLeft.includes('guilds-2JjMmN')) return

                    const divs = document.getElementsByClassName("guilds-2JjMmN")
                    for (let i = 0; i < divs.length; i++) {
                        divs[i].style.width = `${this.settings.sidebar.sidebarWidth}px`;
                    }

                    if (this.settings.sidebar.sidebarWidth > 5) {
                        const divs = document.getElementsByClassName("pill-2RsI5Q")
                        for (let i = 0; i < divs.length; i++) {
                            divs[i].style.visibility = 'hidden';
                        }
                    }

                    if (e) {
                        this.lastLeft = e.target;
                    }
                }
            }
            createListeners(init = false) {
                const self = this
                function createListener(element) {
                    if (typeof element === 'string') {
                        element = document.querySelector(element)
                    }
                    if (!element) return
                    element.addEventListener('mouseenter', self.listenerFunctions.mouseenter)
                    self.listenerFunctions.activeListeners.mouseenter.push(element)
                    element.addEventListener('mouseleave', self.listenerFunctions.mouseleave)
                    self.listenerFunctions.activeListeners.mouseleave.push(element)
                }

                const divs = document.getElementsByClassName("guilds-2JjMmN")
                for (let i = 0; i < divs.length; i++) {
                    createListener(divs[i])
                }

                // Create the listeners for the dms
                if (this.settings.hover.dmsOpen) {
                    createListener('.privateChannels-oVe7HL')
                }

                // Create listener for channels in a server
                if (this.settings.hover.channelOpen) {
                    createListener('.container-1NXEtd')
                }
            }
            removeListeners(target = false) {
                if (target) {
                    target = document.querySelector(target)
                    if (!target) return
                    target.removeEventListener('mouseenter', this.listenerFunctions.mouseenter)
                    target.removeEventListener('mouseleave', this.listenerFunctions.mouseleave)
                } else {
                    const self = this
                    for (const key in self.listenerFunctions.activeListeners) {
                        self.listenerFunctions.activeListeners[key].forEach(element => {
                            if (!element) return
                            element.removeEventListener(key, self.listenerFunctions[key])
                            const index = self.listenerFunctions.activeListeners[key].indexOf(element);
                            if (index > -1) {
                                self.listenerFunctions.activeListeners[key].splice(index, 1);
                            }
                        });
                    }
                }
            }

            // Main Functions
            onLoad() {
                this.defaults = {
                    sidebar: {
                        title:                          'Sidebar Settings',
                        sidebarWidth:					{value: '10',	description: "Width of the Sidebar when Closed",    type: 'number'},
                        sidebarWidthOpen:               {value: '72',   description: "Width of the Sidebar when Open",      type: 'number'},
                        collapseTimer:                  {value: '0.2',    description: "Time in Seconds to Collapse the Sidebar", type: 'number'},
                    },
					hover: {
                        title:                          'Hover Settings',
                        dmsOpen:                		{value: true,   description: "Open the Sidebar when Hovering over DMs", type: 'switch'},
						channelOpen:					{value: false,	description: "Open the Sidebar when Hovering over Channels", type: 'switch'}
					}
                }
            }

            onStart() {
                this.stylesheet = document.head.appendChild(document.createElement("style"));
                this.applyStylesheet()
                this.createListeners()

                // Close the sidebar by default
                this.listenerFunctions.mouseleave()
            }

            onSwitch() {
                this.createListeners()
            }

            onStop() {
                this.stylesheet.innerHTML = '';
                this.listenerFunctions.mouseenter(null, true)
                this.removeListeners()

            }
        };
    })(window.BDFDB_Global.PluginUtils.buildPlugin(config));
})();
