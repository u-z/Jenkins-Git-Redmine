#!groovy
import hudson.model.*;
import jenkins.model.*;

def inst = Jenkins.instance
def uCenter = inst.updateCenter

def env = System.getenv();
def proxy=env['https_proxy']
if (proxy!=null){
    def astr=proxy.split("[/:@]")
    if (astr.length == 7) {
        inst.proxy = new hudson.ProxyConfiguration(astr[5], Integer.decode(astr[6]),astr[3] , astr[4], env['no_proxy'])
        //println(astr[3]+astr[4]+astr[5]+astr[6])
    }
    if (astr.length == 5) {
        inst.proxy = new hudson.ProxyConfiguration(astr[3], Integer.decode(astr[4]),"" , "", env['no_proxy'])
        //println(astr[3]+astr[4])
    }
}
uCenter.updateAllSites()
inst.reload()

