#include <websocketpp/config/asio_no_tls.hpp>

#include <websocketpp/server.hpp>
#include <iostream>
#include <string>
#include <websocketpp/frame.hpp>
#include <Utils/ConfigMap.hpp>
#include <boost/log/trivial.hpp>
typedef websocketpp::server<websocketpp::config::asio> server;

using websocketpp::lib::placeholders::_1;
using websocketpp::lib::placeholders::_2;
using websocketpp::lib::bind;
using websocketpp::lib::error_code;
std::mutex g_tableMut;
using namespace INTELLI;
//ConfigMapPtr g_configMap;

// pull out the type of messages sent by our config
typedef server::message_ptr message_ptr;
uint64_t findNextPort(uint64_t startPort,ConfigMapPtr cfg)
{
  uint64_t tryPort=startPort;
  while (1)
  { uint64_t occupied=0;
    std::string tempKey=std::to_string(tryPort);
    occupied=cfg->tryU64(tempKey,0);
    if(occupied==0)
    {
      return tryPort;
    }
    tryPort++;
  }

}
// Define a callback to handle incoming messages
void on_message(server* s, websocketpp::connection_hdl hdl, message_ptr msg) {
    std::cout << "on_message called with hdl: " << hdl.lock().get()
              << " and message: " << msg->get_payload()
              << std::endl;

    // check for a special command to instruct the server to stop listening so
    // it can be cleanly exited.
    if (msg->get_payload() == "stop-listening") {
        s->stop_listening();
        return;
    }
    if(msg->get_opcode()==websocketpp::frame::opcode::binary)
    {
        std::cout<<"this is a binary,len="+std::to_string(msg->get_payload().length())+"\r\n";
        uint32_t *tb=(uint32_t *)msg->get_payload().data();
        std::cout<<"read"+std::to_string(*tb)+"\r\n";
        return;
    }
    string inStr=msg->get_payload();
    if(inStr== "askPort")
    {
      while (!g_tableMut.try_lock());
      ConfigMapPtr m_configMap=newConfigMap();
      m_configMap->fromFile("usedPorts.csv");
      uint64_t emptyPort=findNextPort(21194,m_configMap);
      std::string tempKey= to_string(emptyPort);
      m_configMap->edit(tempKey,(uint64_t)1);
      std::system("rm usedPorts.csv");
      m_configMap->toFile("usedPorts.csv");
      try {
        s->send(hdl, tempKey, msg->get_opcode());
      } catch (websocketpp::exception const & e) {
        std::cout << "Echo failed because: "
                  << "(" << e.what() << ")" << std::endl;
      }
     // INTELLI_INFO("allocated port "+tempKey);
      g_tableMut.unlock();
    }
    else if(inStr.rfind("clearPort",0)==0)
    {
      string toClearPort=inStr.substr(strlen("clearPort"));
      while (!g_tableMut.try_lock());
      ConfigMapPtr m_configMap=newConfigMap();
      m_configMap->fromFile("usedPorts.csv");
      m_configMap->edit(toClearPort,(uint64_t)0);
      std::system("rm usedPorts.csv");
      m_configMap->toFile("usedPorts.csv");
      try {
        s->send(hdl, "port "+toClearPort+" is cleared", msg->get_opcode());
      } catch (websocketpp::exception const & e) {
        std::cout << "Echo failed because: "
                  << "(" << e.what() << ")" << std::endl;
      }
      //INTELLI_INFO("free port "+toClearPort);
      g_tableMut.unlock();
    }



}

// Define a callback to handle failures accepting connections
void on_end_accept(error_code lib_ec, error_code trans_ec) {
    std::cout << "Accept loop ended "
                << lib_ec.message() << "/" << trans_ec.message() << std::endl;
}

int main(int argc,char **argv) {
    // Create a server endpoint
    server echo_server;
    int port=9002;
 // IntelliLog::setupLoggingFile("vpnPortServer.log");
  //INTELLI_INFO("START UP");
 // return 0;
    try {
        // Set logging settings
        echo_server.set_access_channels(websocketpp::log::alevel::all);
        echo_server.clear_access_channels(websocketpp::log::alevel::frame_payload);

        // Initialize Asio
        echo_server.init_asio();

        // Register our message handler
        echo_server.set_message_handler(bind(&on_message,&echo_server,::_1,::_2));

      if(argc>=2)
      {
        port=atoi(argv[1]);
      }
      INTELLI_INFO("start listening at port"+ to_string(port));

        // Listen on port 114514
        echo_server.listen(port);

        // Start the server accept loop
        echo_server.start_accept(&on_end_accept);

        // Start the ASIO io_service run loop
        echo_server.run();
    } catch (websocketpp::exception const & e) {
        std::cout << e.what() << std::endl;
    } catch (...) {
        std::cout << "other exception" << std::endl;
    }
}