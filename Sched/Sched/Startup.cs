using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(Sched.Startup))]
namespace Sched
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
