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
            "name": "Sidebar Collapse Plugin",
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
				let settingsPanel;
				return settingsPanel = BDFDB.PluginUtils.createSettingsPanel(this, {
					collapseStates: collapseStates,
					children: _ => {
						let settingsItems = [];
				
						settingsItems.push(BDFDB.ReactUtils.createElement(BDFDB.LibraryComponents.CollapseContainer, {
							title: "Sidebar Settings",
							collapseStates: collapseStates,
							children: Object.keys(this.defaults.general).map(key => this.defaults.general[key].type === 'number' ? BDFDB.ReactUtils.createElement(BDFDB.LibraryComponents.SettingsSaveItem, {
                                type: "TextInput",
                                childProps: {
                                    type: "number"
                                },
								plugin: this,
								key: key,
								keys: ["general", key],
								label: this.defaults.general[key].description,
								value: this.settings.general[key]
							}) : BDFDB.ReactUtils.createElement(BDFDB.LibraryComponents.SettingsSaveItem, {
                                type: "Switch",
								plugin: this,
								key: key,
								keys: ["general", key],
								label: this.defaults.general[key].description,
								value: this.settings.general[key]
                            }))
                        }))
						
						return settingsItems;
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

                !this.settings.general.openOnDmsHover ? this.removeListeners(true) : this.createListeners()
                this.listenerFuntions.guilds.mouseout()
                console.log(this.settings.general.openOnDmsHover)
			}

            listenerFuntions = {
                guilds: {
                    isMouseOver: false,
                    mouseenter: () => {
                        console.log("[guild] mouseenter")
                        this.listenerFuntions.guilds.isMouseOver = true

                        document.querySelector('.guilds-2JjMmN').style.width = `${this.settings.general.sidebarWidthOpen}px`;

                        if (this.settings.general.sidebarWidth > 5) {
                            const divs = document.getElementsByClassName("pill-2RsI5Q")
                            for (var i = 0; i < divs.length; i++) {
                                divs[i].style.visibility = 'initial';        
                            }
                        }
                    },
                    mouseout: () => {
                        console.log("[guild] mouseleave")
                        this.listenerFuntions.guilds.isMouseOver = false

                        if (document.querySelector('#guild-context') || this.listenerFuntions.dms.isMouseOver) return
                        document.querySelector('.guilds-2JjMmN').style.width = `${this.settings.general.sidebarWidth}px`;
                        
                        if (this.settings.general.sidebarWidth > 5) {
                            const divs = document.getElementsByClassName("pill-2RsI5Q")
                            for (var i = 0; i < divs.length; i++) {
                                divs[i].style.visibility = 'hidden';        
                            }
                        }
                    }
                },
                dms: {
                    isMouseOver: false,
                    mouseenter: () => {
                        console.log("[dms] mouseenter")
                        this.listenerFuntions.dms.isMouseOver = true

                        document.querySelector('.guilds-2JjMmN').style.width = `${this.settings.general.sidebarWidthOpen}px`;

                        if (this.settings.general.sidebarWidth > 5) {
                            const divs = document.getElementsByClassName("pill-2RsI5Q")
                            for (var i = 0; i < divs.length; i++) {
                                divs[i].style.visibility = 'initial';        
                            }
                        }
                    },
                    mouseout: () => {
                        console.log("[dms] mouseleave")
                        this.listenerFuntions.dms.isMouseOver = false
                        
                        if (document.querySelector('#guild-context') || this.listenerFuntions.guilds.isMouseOver) return
                        document.querySelector('.guilds-2JjMmN').style.width = `${this.settings.general.sidebarWidth}px`;

                        if (this.settings.general.sidebarWidth > 5) {
                            const divs = document.getElementsByClassName("pill-2RsI5Q")
                            for (var i = 0; i < divs.length; i++) {
                                divs[i].style.visibility = 'hidden';        
                            }
                        }
                    }
                }
            }

            createListeners() {
                const dms = document.querySelector('.privateChannels-oVe7HL')
                const guilds = document.querySelector('.guilds-2JjMmN')

                if (guilds) {
                    guilds.addEventListener('mouseover', this.listenerFuntions.guilds.mouseenter)
                    guilds.addEventListener('mouseleave', this.listenerFuntions.guilds.mouseout)
                }

                if (dms && this.settings.general.openOnDmsHover) {
                    dms.addEventListener('mouseover', this.listenerFuntions.dms.mouseenter)
                    dms.addEventListener('mouseleave', this.listenerFuntions.dms.mouseout)
                }
            }

            removeListeners(cfgupdate = false) {
                const dms = document.querySelector('.privateChannels-oVe7HL')
                const guilds = document.querySelector('.guilds-2JjMmN')

                if (dms) {
                    console.log('[dms] removing listeners')
                    dms.removeEventListener('mouseover', this.listenerFuntions.dms.mouseenter)
                    dms.removeEventListener('mouseleave', this.listenerFuntions.dms.mouseout)
                }

                if (guilds && !cfgupdate) {
                    console.log('[guilds] removing listeners')
                    guilds.removeEventListener('mouseover', this.listenerFuntions.guilds.mouseenter)
                    guilds.removeEventListener('mouseleave', this.listenerFuntions.guilds.mouseout)
                }
            }

            stylesheet = null;

            onLoad() {
                this.defaults = {
                    general: {
                        sidebarWidth:					{value: '10',	description: "Width of the Sidebar when Closed",    type: 'number'},
                        sidebarWidthOpen:               {value: '72',   description: "Width of the Sidebar when Open",      type: 'number'},
                        openOnDmsHover:                 {value: true,   description: "Open the Sidebar on Hovering over DMs", type: 'switch'},
                    }
                }
            }

            onStart() {
                this.stylesheet = document.head.appendChild(document.createElement("style"));
                this.stylesheet.innerHTML = `
                .guilds-2JjMmN:after {
                    content: "";
                    width: 1px;
                    position: absolute;
                    left: 0;
                    top: 0;
                    height: 100%;
                    background-color: #191919;
                }
                
                .guilds-2JjMmN {
                    width: 10px;
                    transition: all 0.2s ease-out;
                }
                `;

                this.listenerFuntions.guilds.mouseout()
                this.createListeners()
            }


            onSwitch() {
                this.createListeners()
            }

            onStop() {
                this.stylesheet.innerHTML = '';

                this.listenerFuntions.guilds.mouseenter()
                this.removeListeners
            }
        };
    })(window.BDFDB_Global.PluginUtils.buildPlugin(config));
})();
