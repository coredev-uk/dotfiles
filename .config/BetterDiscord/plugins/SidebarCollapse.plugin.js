/**
 * @name SidebarCollapse
 * @version 1.0.0
 * @description test
 */

module.exports = (_ => {
    const config = {
        "info": {
            "name": "Sidebar Collapse Plugin",
            "version": "1.0",
            "author": "Core",
            "description": "Plugin for Sidebar Collapse"
        }
    };

    return (window.Lightcord && !Node.prototype.isPrototypeOf(window.Lightcord) || window.LightCord && !Node.prototype.isPrototypeOf(window.LightCord) || window.Astra && !Node.prototype.isPrototypeOf(window.Astra)) ? class {
        getName() { return config.info.name; }
        getAuthor() { return config.info.author; }
        getVersion() { return config.info.version; }
        getDescription() { return "Do not use LightCord!"; }
        load() { BdApi.alert("Attention!", "By using LightCord you are risking your Discord Account, due to using a 3rd Party Client. Switch to an official Discord Client (https://discord.com/) with the proper BD Injection (https://betterdiscord.app/)"); }
        start() { }
        stop() { }
    } : !window.BDFDB_Global || (!window.BDFDB_Global.loaded && !window.BDFDB_Global.started) ? class {
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
            privateMouseOver = false;
            guildMouseOver = false;
            listener_funcs = {
                guild_mouseover: () => {
                    console.log('[guild] mouseover')
                    document.querySelector('.guilds-2JjMmN').style.width = '72px';
                    const divs = document.getElementsByClassName("pill-2RsI5Q")
                    for (var i = 0; i < divs.length; i++) {
                        divs[i].style.visibility = 'initial';        
                    }
                    this.guildMouseOver = true
                },
                guild_mouseleave: () => {
                    console.log('[guild] mouseleave')
                    this.guildMouseOver = false
                    if (document.querySelector('#guild-context') || this.privateMouseOver) return
                    document.querySelector('.guilds-2JjMmN').style.width = '10px';
                    const divs = document.getElementsByClassName("pill-2RsI5Q")
                    for (var i = 0; i < divs.length; i++) {
                        divs[i].style.visibility = 'hidden';        
                    }
                },
                dms_mouseover: () => {
                    console.log('[dms] mouseover')
                    document.querySelector('.guilds-2JjMmN').style.width = '72px';
                    const divs = document.getElementsByClassName("pill-2RsI5Q")
                    for (var i = 0; i < divs.length; i++) {
                        divs[i].style.visibility = 'initial';        
                    }
                    this.privateMouseOver = true
                },
                dms_mouseleave: () => {
                    console.log('[dms] mouseleave')
                    this.privateMouseOver = false
                    if (document.querySelector('#guild-context') || this.guildMouseOver) return
                    document.querySelector('.guilds-2JjMmN').style.width = '10px';
                    const divs = document.getElementsByClassName("pill-2RsI5Q")
                    for (var i = 0; i < divs.length; i++) {
                        divs[i].style.visibility = 'hidden';        
                    }
                    this.privateMouseOver = false
                }
            };

            onStart() {
                const dms = document.querySelector('.privateChannels-oVe7HL')
                const guilds = document.querySelector('.guilds-2JjMmN')

                const divs = document.getElementsByClassName("pill-2RsI5Q")
                for (var i = 0; i < divs.length; i++) {
                    divs[i].style.visibility = 'hidden';        
                }

                if (guilds) {
                    guilds.addEventListener('mouseover', this.listener_funcs.guild_mouseover)
                    guilds.addEventListener('mouseleave', this.listener_funcs.guild_mouseleave)
                }

                if (dms) {
                    dms.addEventListener('mouseover', this.listener_funcs.dms_mouseover)
                    dms.addEventListener('mouseleave', this.listener_funcs.dms_mouseleave)
                }
            }


            onSwitch() {
                const dms = document.querySelector('.privateChannels-oVe7HL')

                if (dms) {
                    dms.addEventListener('mouseover', this.listener_funcs.dms_mouseover)
                    dms.addEventListener('mouseleave', this.listener_funcs.dms_mouseleave)
                }
            }

            onStop() {
                const dms = document.querySelector('.privateChannels-oVe7HL')
                const guilds = document.querySelector('.guilds-2JjMmN')

                const divs = document.getElementsByClassName("pill-2RsI5Q")
                for (var i = 0; i < divs.length; i++) {
                    divs[i].style.visibility = 'visible';        
                }
                
                if (dms) {
                    dms.removeEventListener('mouseover', this.listener_funcs.dms_mouseover)
                    dms.removeEventListener('mouseleave', this.listener_funcs.dms_mouseleave)
                }

                if (guilds) {
                    guilds.style.width = "72px"
                    guilds.removeEventListener('mouseover', this.listener_funcs.guild_mouseover)
                    guilds.removeEventListener('mouseleave', this.listener_funcs.guild_mouseleave)
                }
            }
        };
    })(window.BDFDB_Global.PluginUtils.buildPlugin(config));
})();
