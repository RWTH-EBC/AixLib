within AixLib.Utilities.Communication.SocketCommunication.UsersGuide.Documentation;
class Errors "Windows sockets errors"
   extends Modelica.Icons.Information;

   annotation (preferredView="info", Documentation(info="<HTML>

<p>Table that gives all possible error codes and messages of the Winsock application.
Error codes as specified on Winsock homepage. (c) Microsoft
</p>

<table summary=\"This are all possible error codes reported by Winsock\">
<tr>
<th> Return code/ value</th><th> Description</th>
</tr>

<tr>
<td> WSA_INVALID_HANDLE <br /> 6 </td><td> 
Specified event object handle is invalid.<br /> An application attempts to use an event object, but the specified handle is not valid. Note that this error is returned by the operating system, so the error number may change in future releases of Windows.
</td>
</tr>

<tr>
<td> WSA_NOT_ENOUGH_MEMORY <br /> 8 </td><td> 
Insufficient memory available.<br /> An application used a Windows Sockets function that directly maps to a Windows function. The Windows function is indicating a lack of required memory resources. Note that this error is returned by the operating system, so the error number may change in future releases of Windows.
</td>
</tr>

<tr>
<td> WSA_INVALID_PARAMETER <br /> 87 </td><td> 
One or more parameters are invalid.<br /> An application used a Windows Sockets function which directly maps to a Windows function. The Windows function is indicating a problem with one or more parameters. Note that this error is returned by the operating system, so the error number may change in future releases of Windows.
</td>
</tr>

<tr>
<td> WSA_OPERATION_ABORTED <br /> 995 </td><td> 
Overlapped operation aborted.<br /> An overlapped operation was canceled due to the closure of the socket, or the execution of the SIO_FLUSH command in WSAIoctl. Note that this error is returned by the operating system, so the error number may change in future releases of Windows.
</td>
</tr>

<tr>
<td> WSA_IO_INCOMPLETE <br /> 996 </td><td> 
Overlapped I/O event object not in signaled state.<br /> The application has tried to determine the status of an overlapped operation which is not yet completed. Applications that use WSAGetOverlappedResult (with the fWait flag set to FALSE) in a polling mode to determine when an overlapped operation has completed, get this error code until the operation is complete. Note that this error is returned by the operating system, so the error number may change in future releases of Windows.
</td>
</tr>

<tr>
<td> WSA_IO_PENDING <br /> 997 </td><td> 
Overlapped operations will complete later.<br /> The application has initiated an overlapped operation that cannot be completed immediately. A completion indication will be given later when the operation has been completed. Note that this error is returned by the operating system, so the error number may change in future releases of Windows.

</td>
</tr>

<tr>
<td> WSAEINTR <br /> 10004 </td><td> 
Interrupted function call.<br /> A blocking operation was interrupted by a call to WSACancelBlockingCall.
</td>
</tr>

<tr>
<td> WSAEBADF <br /> 10009 </td><td> 
File handle is not valid.<br /> The file handle supplied is not valid.
</td>
</tr>

<tr>
<td> WSAEACCES <br /> 10013 </td><td> 
Permission denied.<br /> An attempt was made to access a socket in a way forbidden by its access permissions. An example is using a broadcast address for sendto without broadcast permission being set using setsockopt(SO_BROADCAST). Another possible reason for the WSAEACCES error is that when the bind function is called (on Windows NT 4.0 with SP4 and later), another application, service, or kernel mode driver is bound to the same address with exclusive access. Such exclusive access is a new feature of Windows NT 4.0 with SP4 and later, and is implemented by using the SO_EXCLUSIVEADDRUSE option.
</td>
</tr>

<tr>
<td> WSAEFAULT <br /> 10014 </td><td> 
Bad address.<br /> The system detected an invalid pointer address in attempting to use a pointer argument of a call. This error occurs if an application passes an invalid pointer value, or if the length of the buffer is too small. For instance, if the length of an argument, which is a sockaddr structure, is smaller than the sizeof(sockaddr).
</td>
</tr>

<tr>
<td> WSAEINVAL <br /> 10022 </td><td> 
Invalid argument.<br /> Some invalid argument was supplied (for example, specifying an invalid level to the setsockopt function). In some instances, it also refers to the current state of the socket, for instance, calling accept on a socket that is not listening.
</td>
</tr>

<tr>
<td> WSAEMFILE <br /> 10024 </td><td> 
Too many open files.<br /> Too many open sockets. Each implementation may have a maximum number of socket handles available, either globally, per process, or per thread.
</td>
</tr>

<tr>
<td> WSAEWOULDBLOCK <br /> 10035 </td><td> 
Resource temporarily unavailable. <br /> This error is returned from operations on nonblocking sockets that cannot be completed immediately, for example recv when no data is queued to be read from the socket. It is a nonfatal error, and the operation should be retried later. It is normal for WSAEWOULDBLOCK to be reported as the result from calling connect on a nonblocking SOCK_STREAM socket, since some time must elapse for the connection to be established.
</td>
</tr>

<tr>
<td> WSAEINPROGRESS <br /> 10036 </td><td> 
Resource temporarily unavailable.<br /> This error is returned from operations on nonblocking sockets that cannot be completed immediately, for example recv when no data is queued to be read from the socket. It is a nonfatal error, and the operation should be retried later. It is normal for WSAEWOULDBLOCK to be reported as the result from calling connect on a nonblocking SOCK_STREAM socket, since some time must elapse for the connection to be established.
</td>
</tr>

<tr>
<td> WSAEALREADY <br /> 10037 </td><td> 
Operation already in progress.<br /> An operation was attempted on a nonblocking socket with an operation already in progress, that is, calling connect a second time on a nonblocking socket that is already connecting, or canceling an asynchronous request (WSAAsyncGetXbyY) that has already been canceled or completed.
</td>
</tr>

<tr>
<td> WSAENOTSOCK <br /> 10038 </td><td> 
Socket operation on nonsocket.<br /> An operation was attempted on something that is not a socket. Either the socket handle parameter did not reference a valid socket, or for select, a member of an fd_set was not valid.
</td>
</tr>

<tr>
<td> WSAEDESTADDRREQ <br /> 10039 </td><td> 
Destination address required. <br />  A required address was omitted from an operation on a socket. For example, this error is returned if sendto is called with the remote address of ADDR_ANY.
</td>
</tr>

<tr>
<td> WSAEMSGSIZE <br /> 10040 </td><td> 
Message too long.<br /> A message sent on a datagram socket was larger than the internal message buffer or some other network limit, or the buffer used to receive a datagram was smaller than the datagram itself.
</td>
</tr>

<tr>
<td> WSAEPROTOTYPE <br /> 10041 </td><td> 
Protocol wrong type for socket.<br /> A protocol was specified in the socket function call that does not support the semantics of the socket type requested. For example, the ARPA Internet UDP protocol cannot be specified with a socket type of SOCK_STREAM.
</td>
</tr>

<tr>
<td> WSAENOPROTOOPT <br /> 10042 </td><td> 
Bad protocol option.<br /> An unknown, invalid or unsupported option or level was specified in a getsockopt or setsockopt call.
</td>
</tr>

<tr>
<td> WSAEPROTONOSUPPORT <br /> 10043 </td><td> 
Protocol not supported.<br />    The requested protocol has not been configured into the system, or no implementation for it exists. For example, a socket call requests a SOCK_DGRAM socket, but specifies a stream protocol.
</td>
</tr>

<tr>
<td> WSAESOCKTNOSUPPORT <br /> 10044 </td><td> 
Socket type not supported.<br />    The support for the specified socket type does not exist in this address family. For example, the optional type SOCK_RAW might be selected in a socket call, and the implementation does not support SOCK_RAW sockets at all.
</td>
</tr>

<tr>
<td> WSAEOPNOTSUPP <br /> 10045 </td><td> 
Operation not supported.<br />    The attempted operation is not supported for the type of object referenced. Usually this occurs when a socket descriptor to a socket that cannot support this operation is trying to accept a connection on a datagram socket.
</td>
</tr>

<tr>
<td> WSAEPFNOSUPPORT <br /> 10046 </td><td> 
Protocol family not supported.<br />    The protocol family has not been configured into the system or no implementation for it exists. This message has a slightly different meaning from WSAEAFNOSUPPORT. However, it is interchangeable in most cases, and all Windows Sockets functions that return one of these messages also specify WSAEAFNOSUPPORT.
</td>
</tr>

<tr>
<td> WSAEAFNOSUPPORT <br /> 10047 </td><td> 
Address family not supported by protocol family.<br />    An address incompatible with the requested protocol was used. All sockets are created with an associated address family (that is, AF_INET for Internet Protocols) and a generic protocol type (that is, SOCK_STREAM). This error is returned if an incorrect protocol is explicitly requested in the socket call, or if an address of the wrong family is used for a socket, for example, in sendto.
</td>
</tr>

<tr>
<td> WSAEADDRINUSE <br /> 10048 </td><td> 

Address already in use.<br />Typically, only one usage of each socket address (protocol/IP address/port) is permitted. This error occurs if an application attempts to bind a socket  to an IP address/port that has already been used for an existing socket,   or a socket that was not closed properly, or one that is still in the process   of closing. For server applications that need to bind multiple sockets to the   same port number, consider using setsockopt (SO_REUSEADDR). Client applications usually need not call bind at all, as connect chooses an unused port automatically. When bind is called with a wildcard address (involving ADDR_ANY), a WSAEADDRINUSE error could be delayed until the specific address is committed. This could happen with a call to another function later, including connect, listen, WSAConnect, or WSAJoinLeaf.

</td>
</tr>

<tr>
<td> WSAEADDRNOTAVAIL <br /> 10049 </td><td> 

Cannot assign requested address.<br /> The requested address is not valid in its context. This normally results from an attempt to bind to an address that is not valid for the local computer. This can also result from connect, sendto, WSAConnect, WSAJoinLeaf, or WSASendTo when the remote address or port is not valid for a remote computer (for example, address or port 0).

</td>
</tr>

<tr>
<td> WSAENETDOWN <br /> 10050 </td><td> 

Network is down.<br /> A socket operation encountered a dead network. This could indicate a serious failure of the network system (that is, the protocol stack that the Windows Sockets DLL runs over), the network interface, or the local network itself.

</td>
</tr>

<tr>
<td> WSAENETUNREACH <br /> 10051 </td><td> 

Network is unreachable.<br />   A socket operation was attempted to an unreachable network. This usually means the local software knows no route to reach the remote host.

</td>
</tr>

<tr>
<td> WSAENETRESET <br /> 10052 </td><td> 

Network dropped connection on reset.<br />   The connection has been broken due to keep-alive activity detecting a failure while the operation was in progress. It can also be returned by setsockopt if an attempt is made to set SO_KEEPALIVE on a connection that has already failed.

</td>
</tr>

<tr>
<td> WSAECONNABORTED <br /> 10053 </td><td> 

Software caused connection abort.<br />

    An established connection was aborted by the software in your host computer, possibly due to a data transmission time-out or protocol error.

</td>
</tr>

<tr>
<td> WSAECONNRESET <br /> 10054 </td><td> 

Connection reset by peer.<br />

    An existing connection was forcibly closed by the remote host. This normally results if the peer application on the remote host is suddenly stopped, the host is rebooted, the host or remote network interface is disabled, or the remote host uses a hard close (see setsockopt for more information on the SO_LINGER option on the remote socket). This error may also result if a connection was broken due to keep-alive activity detecting a failure while one or more operations are in progress. Operations that were in progress fail with WSAENETRESET. Subsequent operations fail with WSAECONNRESET.

</td>
</tr>

<tr>
<td> WSAENOBUFS <br /> 10055 </td><td> 

No buffer space available.<br />

    An operation on a socket could not be performed because the system lacked sufficient buffer space or because a queue was full.

</td>
</tr>

<tr>
<td> WSAEISCONN <br /> 10056 </td><td> 

Socket is already connected.<br />

    A connect request was made on an already-connected socket. Some implementations also return this error if sendto is called on a connected SOCK_DGRAM socket (for SOCK_STREAM sockets, the to parameter in sendto is ignored) although other implementations treat this as a legal occurrence.

</td>
</tr>

<tr>
<td> WSAENOTCONN <br /> 10057 </td><td> 

Socket is not connected.<br />

A request to send or receive data was disallowed because the socket is not connected and (when sending on a datagram socket using sendto) no address was supplied. Any other type of operation might also return this error, for example, setsockopt setting SO_KEEPALIVE if the connection has been reset.

</td>
</tr>

<tr>
<td> WSAESHUTDOWN <br /> 10058 </td><td> 

Cannot send after socket shutdown.<br />

    A request to send or receive data was disallowed because the socket had already been shut down in that direction with a previous shutdown call. By calling shutdown a partial close of a socket is requested, which is a signal that sending or receiving, or both have been discontinued.

</td>
</tr>

<tr>
<td> WSAETOOMANYREFS <br /> 10059 </td><td> 

Too many references.<br />

    Too many references to some kernel object.

</td>
</tr>

<tr>
<td> WSAETIMEDOUT <br /> 10060 </td><td> 

Connection timed out.<br />

    A connection attempt failed because the connected party did not properly respond after a period of time, or the established connection failed because the connected host has failed to respond.

</td>
</tr>

<tr>
<td> WSAECONNREFUSED <br /> 10061 </td><td> 

Connection refused.<br />

No connection could be made because the target computer actively refused it. This usually results from trying to connect to a service that is inactive on the foreign host, that is, one with no server application running.

</td>
</tr>

<tr>
<td> WSAELOOP <br /> 10062 </td><td> 

Cannot translate name.<br />

    Cannot translate a name.

</td>
</tr>

<tr>
<td> WSAENAMETOOLONG <br /> 10063 </td><td> 

Name too long.<br />

    A name component or a name was too long.

</td>
</tr>

<tr>
<td> WSAEHOSTDOWN <br /> 10064 </td><td> 

Host is down.<br />

    A socket operation failed because the destination host is down. A socket operation encountered a dead host. Networking activity on the local host has not been initiated. These conditions are more likely to be indicated by the error WSAETIMEDOUT.

</td>
</tr>

<tr>
<td> WSAEHOSTUNREACH <br /> 10065 </td><td> 

No route to host.<br />

    A socket operation was attempted to an unreachable host. See WSAENETUNREACH.

</td>
</tr>

<tr>
<td> WSAENOTEMPTY <br /> 10066 </td><td> 

Too many processes.<br />

    A Windows Sockets implementation may have a limit on the number of applications that can use it simultaneously. WSAStartup may fail with this error if the limit has been reached.

</td>
</tr>


<tr>
<td> WSAEUSERS <br /> 10068 </td><td> 

User quota exceeded.<br />

    Ran out of user quota.

</td>
</tr>


<tr>
<td> WSAEDQUOT <br /> 10069 </td><td> 

Disk quota exceeded.<br />

    Ran out of disk quota.

</td>
</tr>


<tr>
<td> WSAESTALE <br /> 10070 </td><td> 

Stale file handle reference.<br />

    The file handle reference is no longer available.

</td>
</tr>


<tr>
<td> 
WSAEREMOTE
 <br /> 10071 </td><td> 

Item is remote.<br />

    The item is not available locally.

</td>
</tr>


<tr>
<td> WSASYSNOTREADY <br /> 10091 </td><td> 

Network subsystem is unavailable.<br />

    This error is returned by WSAStartup if the Windows Sockets implementation cannot function at this time because the underlying system it uses to provide network services is currently unavailable. Users should check:

    - That the appropriate Windows Sockets DLL file is in the current path.
    - That they are not trying to use more than one Windows Sockets implementation simultaneously. If there is more than one Winsock DLL on your system, be sure the first one in the path is appropriate for the network subsystem currently loaded.
    - The Windows Sockets implementation documentation to be sure all necessary components are currently installed and configured correctly.

</td>
</tr>

<tr>
<td> WSAVERNOTSUPPORTED <br /> 10092 </td><td> 

Winsock.dll version out of range.<br />

    The current Windows Sockets implementation does not support the Windows Sockets specification version requested by the application. Check that no old Windows Sockets DLL files are being accessed.

</td>
</tr>

<tr>
<td> WSANOTINITIALISED <br /> 10093 </td><td> 

Successful WSAStartup not yet performed.<br />

    Either the application has not called WSAStartup or WSAStartup failed. The application may be accessing a socket that the current active task does not own (that is, trying to share a socket between tasks), or WSACleanup has been called too many times.

</td>
</tr>


<tr>
<td> WSAEDISCON <br /> 10101 </td><td> 

Graceful shutdown in progress.<br />

    Returned by WSARecv and WSARecvFrom to indicate that the remote party has initiated a graceful shutdown sequence.

</td>
</tr>


<tr>
<td> WSAENOMORE <br /> 10102 </td><td> 

No more results.<br />

    No more results can be returned by the WSALookupServiceNext function.

</td>
</tr>

<tr>
<td> WSAECANCELLED <br /> 10103 </td><td> 

Call has been canceled.<br />

    A call to the WSALookupServiceEnd function was made while this call was still processing. The call has been canceled.

</td>
</tr>

<tr>
<td> WSAEINVALIDPROCTABLE <br /> 10104 </td><td> 
Procedure call table is invalid.<br />

    The service provider procedure call table is invalid. A service provider returned a bogus procedure table to Ws2_32.dll. This is usually caused by one or more of the function pointers being NULL.

</td>
</tr>

<tr>
<td> WSAEINVALIDPROVIDER <br /> 10105 </td><td> 

Service provider is invalid.<br />

    The requested service provider is invalid. This error is returned by the WSCGetProviderInfo and WSCGetProviderInfo32 functions if the protocol entry specified could not be found. This error is also returned if the service provider returned a version number other than 2.0.

</td>
</tr>

<tr>
<td> WSAEPROVIDERFAILEDINIT <br /> 10106 </td><td> 

Service provider failed to initialize.<br />

    The requested service provider could not be loaded or initialized. This error is returned if either a service provider's DLL could not be loaded (LoadLibrary failed) or the provider's WSPStartup or NSPStartup function failed.

</td>
</tr>

<tr>
<td> WSASYSCALLFAILURE <br /> 10107 </td><td> 

System call failure.<br />

    A system call that should never fail has failed. This is a generic error code, returned under various conditions.

    Returned when a system call that should never fail does fail. For example, if a call to WaitForMultipleEvents fails or one of the registry functions fails trying to manipulate the protocol/namespace catalogs.

    Returned when a provider does not return SUCCESS and does not provide an extended error code. Can indicate a service provider implementation error.

</td>
</tr>

<tr>
<td> WSASERVICE_NOT_FOUND <br /> 10108 </td><td> 

Service not found.<br />

    No such service is known. The service cannot be found in the specified name space.

</td>
</tr>

<tr>
<td> WSATYPE_NOT_FOUND <br /> 10109 </td><td> 

Class type not found.<br />

    The specified class was not found.

</td>
</tr>

<tr>
<td> WSA_E_NO_MORE <br /> 10110 </td><td> 

No more results.<br />

    No more results can be returned by the WSALookupServiceNext function.

</td>
</tr>

<tr>
<td> WSA_E_CANCELLED <br /> 10111 </td><td> 

Call was canceled.<br />

    A call to the WSALookupServiceEnd function was made while this call was still processing. The call has been canceled.

</td>
</tr>

<tr>
<td> WSAEREFUSED <br /> 10112 </td><td> 

Database query was refused.<br />

    A database query failed because it was actively refused.

</td>
</tr>

<tr>
<td> WSAHOST_NOT_FOUND <br /> 11001 </td><td> 

Host not found.<br />

    No such host is known. The name is not an official host name or alias, or it cannot be found in the database(s) being queried. This error may also be returned for protocol and service queries, and means that the specified name could not be found in the relevant database.

</td>
</tr>

<tr>
<td> WSATRY_AGAIN <br /> 11002 </td><td> 

Nonauthoritative host not found.<br />

    This is usually a temporary error during host name resolution and means that the local server did not receive a response from an authoritative server. A retry at some time later may be successful.

</td>
</tr>

<tr>
<td> WSANO_RECOVERY <br /> 11003 </td><td> 

This is a nonrecoverable error.<br />

    This indicates that some sort of nonrecoverable error occurred during a database lookup. This may be because the database files (for example, BSD-compatible HOSTS, SERVICES, or PROTOCOLS files) could not be found, or a DNS request was returned by the server with a severe error.

</td>
</tr>

<tr>
<td> WSANO_DATA <br /> 11004 </td><td> 

Valid name, no data record of requested type.<br />

The requested name is valid and was found in the database, but it does not have the correct associated data being resolved for. The usual example for this is a host name-to-address translation attempt (using gethostbyname or WSAAsyncGetHostByName) which uses the DNS (Domain Name Server). An MX record is returned but no A record, indicating the host itself exists, but is not directly reachable.

</td>
</tr>

<tr>
<td> WSA_QOS_RECEIVERS <br /> 11005 </td><td> 

QoS receivers.<br />

    At least one QoS reserve has arrived.

</td>
</tr>

<tr>
<td> WSA_QOS_SENDERS <br /> 11006 </td><td> 

QoS senders.<br />

    At least one QoS send path has arrived.

</td>
</tr>

<tr>
<td> WSA_QOS_NO_SENDERS <br /> 11007 </td><td> 

No QoS senders.<br />

    There are no QoS senders.

</td>
</tr>

<tr>
<td> WSA_QOS_NO_RECEIVERS <br /> 11008 </td><td> 

QoS no receivers.<br />

    There are no QoS receivers.

</td>
</tr>

<tr>
<td> WSA_QOS_REQUEST_CONFIRMED <br /> 11009 </td><td> 

QoS request confirmed.<br />

    The QoS reserve request has been confirmed.

</td>
</tr>

<tr>
<td> WSA_QOS_ADMISSION_FAILURE <br /> 11010 </td><td> 

QoS admission error.<br />

    A QoS error occurred due to lack of resources.

</td>
</tr>


<tr>
<td> WSA_QOS_POLICY_FAILURE <br /> 11011 </td><td> 

QoS policy failure.<br />

    The QoS request was rejected because the policy system couldn't allocate the requested resource within the existing policy.

</td>
</tr>

<tr>
<td> WSA_QOS_BAD_STYLE <br /> 11012 </td><td> 

QoS bad style.<br />

    An unknown or conflicting QoS style was encountered.

</td>
</tr>

<tr>
<td> WSA_QOS_BAD_OBJECT <br /> 11013 </td><td> 

QoS bad object.<br />

    A problem was encountered with some part of the filterspec or the provider-specific buffer in general.

</td>
</tr>

<tr>
<td> WSA_QOS_TRAFFIC_CTRL_ERROR <br /> 11014 </td><td> 

QoS traffic control error.<br />

    An error with the underlying traffic control (TC) API as the generic QoS request was converted for local enforcement by the TC API. This could be due to an out of memory error or to an internal QoS provider error.

</td>
</tr>

<tr>
<td> WSA_QOS_GENERIC_ERROR <br /> 11015 </td><td> 

QoS generic error.<br />

    A general QoS error.

</td>
</tr>

<tr>
<td> WSA_QOS_ESERVICETYPE <br /> 11016 </td><td> 

QoS service type error.<br />

    An invalid or unrecognized service type was found in the QoS flowspec.

</td>
</tr>

<tr>
<td> WSA_QOS_EFLOWSPEC <br /> 11017 </td><td> 

QoS flowspec error.<br />

    An invalid or inconsistent flowspec was found in the QOS structure.

</td>
</tr>

<tr>
<td> WSA_QOS_EFILTERSTYLE <br /> 11019 </td><td> 

Invalid QoS filter style.<br />

    An invalid QoS filter style was used.

</td>
</tr>
<tr>
<td> WSA_QOS_EFILTERTYPE <br /> 11020 </td><td> 

Invalid QoS filter type.<br />

    An invalid QoS filter type was used.

</td>
</tr>

<tr>
<td> WSA_QOS_EFILTERCOUNT <br /> 10021 </td><td> 

Incorrect QoS filter count.<br />

    An incorrect number of QoS FILTERSPECs were specified in the FLOWDESCRIPTOR.

</td>
</tr>

<tr>
<td> WSA_QOS_EOBJLENGTH <br /> 11022 </td><td> 

Invalid QoS object length.<br />

    An object with an invalid ObjectLength field was specified in the QoS provider-specific buffer.

</td>
</tr>

<tr>
<td> WSA_QOS_EFLOWCOUNT <br /> 11023 </td><td> 

Incorrect QoS flow count.<br />

    An incorrect number of flow descriptors was specified in the QoS structure.

</td>
</tr>

<tr>
<td> WSA_QOS_EUNKOWNPSOBJ <br /> 11024 </td><td> 

Unrecognized QoS object.<br />

    An unrecognized object was found in the QoS provider-specific buffer.

</td>
</tr>

<tr>
<td> WSA_QOS_EPOLICYOBJ <br /> 11025 </td><td> 

Invalid QoS policy object.<br />

    An invalid policy object was found in the QoS provider-specific buffer.

</td>
</tr>

<tr>
<td> WSA_QOS_EFLOWDESC <br /> 11026 </td><td> 

Invalid QoS flow descriptor.<br />

    An invalid QoS flow descriptor was found in the flow descriptor list.

</td>
</tr>

<tr>
<td> WSA_QOS_EPSFLOWSPEC <br /> 11027 </td><td> 

Invalid QoS provider-specific flowspec.<br />

    An invalid or inconsistent flowspec was found in the QoS provider-specific buffer.

</td>
</tr>

<tr>
<td> WSA_QOS_EPSFILTERSPEC <br /> 11028 </td><td> 

Invalid QoS provider-specific filterspec.<br />

    An invalid FILTERSPEC was found in the QoS provider-specific buffer.

</td>
</tr>

<tr>
<td> WSA_QOS_ESDMODEOBJ <br /> 11029 </td><td> 

Invalid QoS shape discard mode object.<br />

    An invalid shape discard mode object was found in the QoS provider-specific buffer.

</td>
</tr>

<tr>
<td> WSA_QOS_ESHAPERATEOBJ <br /> 11030 </td><td> 

Invalid QoS shaping rate object.<br />

    An invalid shaping rate object was found in the QoS provider-specific buffer.

</td>
</tr>


<tr>
<td> WSA_QOS_RESERVED_PETYPE <br /> 11031 </td><td> 

Reserved policy QoS element type.<br />

    A reserved policy element was found in the QoS provider-specific buffer.

</td>
</tr>


</table>
</HTML>
",
revisions="<HTML>
<ul>
 <li><i>October 07, 2015&nbsp;</i>
         by Georg Ferdinand Schneider:<br />
         Revised for publishing</li>
</ul>
</HTML>"));
end Errors;
