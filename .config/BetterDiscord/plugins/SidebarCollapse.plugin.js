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
    } : (([Plugin]) => {
        return class SidebarCollapse extends Plugin {
            listener_funcs = {
                guilds: {
                    isMouseOver: false,
                    mouseenter: () => {
                        console.log("[guild] mouseenter")
                        document.querySelector('.guilds-2JjMmN').style.width = '72px';
                        const divs = document.getElementsByClassName("pill-2RsI5Q")
                        for (var i = 0; i < divs.length; i++) {
                            divs[i].style.visibility = 'initial';        
                        }
                        this.listener_funcs.guilds.isMouseOver = true
                    },
                    mouseout: () => {
                        console.log("[guild] mouseleave")
                        this.listener_funcs.guilds.isMouseOver = false
                        if (document.querySelector('#guild-context') || this.listener_funcs.dms.isMouseOver) return
                        document.querySelector('.guilds-2JjMmN').style.width = '10px';
                        const divs = document.getElementsByClassName("pill-2RsI5Q")
                        for (var i = 0; i < divs.length; i++) {
                            divs[i].style.visibility = 'hidden';        
                        }
                    }
                },
                dms: {
                    isMouseOver: false,
                    mouseenter: () => {
                        console.log("[dms] mouseenter")
                        document.querySelector('.guilds-2JjMmN').style.width = '72px';
                        const divs = document.getElementsByClassName("pill-2RsI5Q")
                        for (var i = 0; i < divs.length; i++) {
                            divs[i].style.visibility = 'initial';        
                        }
                        this.listener_funcs.dms.isMouseOver = true
                    },
                    mouseout: () => {
                        console.log("[dms] mouseleave")
                        this.listener_funcs.dms.isMouseOver = false
                        if (document.querySelector('#guild-context') || this.listener_funcs.guilds.isMouseOver) return
                        document.querySelector('.guilds-2JjMmN').style.width = '10px';
                        const divs = document.getElementsByClassName("pill-2RsI5Q")
                        for (var i = 0; i < divs.length; i++) {
                            divs[i].style.visibility = 'hidden';        
                        }
                    }
                }
            };

            stylesheet = null;

            onStart() {
                // Main Stuff
                const dms = document.querySelector('.privateChannels-oVe7HL')
                const guilds = document.querySelector('.guilds-2JjMmN')

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

                // Listeners
                const divs = document.getElementsByClassName("pill-2RsI5Q")
                for (var i = 0; i < divs.length; i++) {
                    divs[i].style.visibility = 'hidden';        
                }

                if (guilds) {
                    guilds.addEventListener('mouseover', this.listener_funcs.guilds.mouseenter)
                    guilds.addEventListener('mouseleave', this.listener_funcs.guilds.mouseout)
                }

                if (dms) {
                    dms.addEventListener('mouseover', this.listener_funcs.dms.mouseenter)
                    dms.addEventListener('mouseleave', this.listener_funcs.dms.mouseout)
                }
            }


            onSwitch() {
                const dms = document.querySelector('.privateChannels-oVe7HL')
                const guilds = document.querySelector('.guilds-2JjMmN')

                if (dms) {
                    dms.addEventListener('mouseover', this.listener_funcs.dms.mouseenter)
                    dms.addEventListener('mouseleave', this.listener_funcs.dms.mouseout)
                }

                if (guilds) {
                    guilds.addEventListener('mouseover', this.listener_funcs.guilds.mouseenter)
                    guilds.addEventListener('mouseleave', this.listener_funcs.guilds.mouseout)
                }
            }

            onStop() {
                this.stylesheet.innerHTML = '';

                const dms = document.querySelector('.privateChannels-oVe7HL')
                const guilds = document.querySelector('.guilds-2JjMmN')

                const divs = document.getElementsByClassName("pill-2RsI5Q")
                for (var i = 0; i < divs.length; i++) {
                    divs[i].style.visibility = 'visible';        
                }

                if (dms) {
                    dms.removeEventListener('mouseover', this.listener_funcs.dms.mouseenter)
                    dms.removeEventListener('mouseleave', this.listener_funcs.dms.mouseout)
                }

                if (guilds) {
                    guilds.style.width = "72px"
                    guilds.removeEventListener('mouseover', this.listener_funcs.guilds.mouseenter)
                    guilds.removeEventListener('mouseleave', this.listener_funcs.guilds.mouseout)
                }
            }
        };
    })(window.BDFDB_Global.PluginUtils.buildPlugin(config));
})();
