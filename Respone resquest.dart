// //1.Thông tin tạo tài khoản.
// var response_user_login = await http.post(
//           Uri.parse("https://smarthome.test.makipos.net:3029/users-service/users/authentication?_v=1"),
//           headers: {
//             "Content-type": "application/json; charset=utf-8"
//           },
//           body: jsonEncode({
//             "strategy": "local",
//             "username": "BMS_admin",
//             "password": "01012023"
//           })
//           );
// +Response userlogin.
// +Trả về thông tin tài khoản.
// + Cần những thông tin sau cho response_user_login:
//   - url:https://smarthome.test.makipos.net:3029/users-service/users/authentication?_v=1
//   - headers: {
//             "Content-type": "application/json; charset=utf-8"
//           },
//   -body: jsonEncode({
//             "strategy": "local",
//             "username": "BMS_admin",
//             "password": "01012023"
//           })
//
// //2.Tạo tài khoản.
//  var response_create_user = await http.post(
//           Uri.parse("https://smarthome.test.makipos.net:3029/users"),
//           headers: {
//             "Content-type": "application/json; charset=utf-8"
//           },
//           body: jsonEncode({
//             "username": "BMS_admin",
//             "password": "01012023"
//           })
//           );
// +Response create.
// +Trả về thông báo tạo tài .
// + Cần những thông tin sau cho response_create_user:
//   - url:https://smarthome.test.makipos.net:3029/users
//   - headers: {
//             "Content-type": "application/json; charset=utf-8"
//           },
//   -body: jsonEncode({
//             "username": "BMS_admin",
//             "password": "01012023"
//           })
//
// //3.Thông tin all tài khoản.
// var responseGet_User = await http.get(
//           Uri.parse("https://smarthome.test.makipos.net:3029/users"),
//           headers: {
//             "Authorization":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2M2I1M2M0NDYxMjVkYjAwMDdjYTIwZmMiLCJ1c2VybmFtZSI6IkJNU19hZG1pbiIsInR5cGUiOiJ1c2VyIiwiaWF0IjoxNjcyODI4NTA3LCJleHAiOjEwMzEyODI4NTA3LCJhdWQiOiJodHRwOi8vc2VydmVyLm1ha2lwb3MubmV0OjMwMjgiLCJpc3MiOiJodHRwOi8vc2VydmVyLm1ha2lwb3MubmV0OjMwMjgiLCJzdWIiOiIiLCJqdGkiOiI0MjA5OTUxNS0zZmY2LTQ0OTgtYmMxYS02NDg1MmEzM2U5ZjcifQ.HfJz87PI0G1T9nUF0doesD6sY-KTKSbZuJgaWfWN0Uo"
//           },
//       );
// +Response viewusers.
// +Trả về thông tin tất cả tài khoản.
// + Cần những thông tin sau cho responseGet_User:
//   - url:https://smarthome.test.makipos.net:3029/users
//   - headers: {
//             "Authorization":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2M2I1M2M0NDYxMjVkYjAwMDdjYTIwZmMiLCJ1c2VybmFtZSI6IkJNU19hZG1pbiIsInR5cGUiOiJ1c2VyIiwiaWF0IjoxNjcyODI4NTA3LCJleHAiOjEwMzEyODI4NTA3LCJhdWQiOiJodHRwOi8vc2VydmVyLm1ha2lwb3MubmV0OjMwMjgiLCJpc3MiOiJodHRwOi8vc2VydmVyLm1ha2lwb3MubmV0OjMwMjgiLCJzdWIiOiIiLCJqdGkiOiI0MjA5OTUxNS0zZmY2LTQ0OTgtYmMxYS02NDg1MmEzM2U5ZjcifQ.HfJz87PI0G1T9nUF0doesD6sY-KTKSbZuJgaWfWN0Uo"
//           },
//
// //4.Thông tin thiết bị.
// var responseGet_Listdevice = await http.get(
//         Uri.parse("https://smarthome.test.makipos.net:3029/devices"),
//         headers: {
//           "Authorization":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2M2I1M2M0NDYxMjVkYjAwMDdjYTIwZmMiLCJ1c2VybmFtZSI6IkJNU19hZG1pbiIsInR5cGUiOiJ1c2VyIiwiaWF0IjoxNjcyODI4NTA3LCJleHAiOjEwMzEyODI4NTA3LCJhdWQiOiJodHRwOi8vc2VydmVyLm1ha2lwb3MubmV0OjMwMjgiLCJpc3MiOiJodHRwOi8vc2VydmVyLm1ha2lwb3MubmV0OjMwMjgiLCJzdWIiOiIiLCJqdGkiOiI0MjA5OTUxNS0zZmY2LTQ0OTgtYmMxYS02NDg1MmEzM2U5ZjcifQ.HfJz87PI0G1T9nUF0doesD6sY-KTKSbZuJgaWfWN0Uo"
//         },
//       );
// +Response device_.
// +Trả về thông tin thiết .
// + Cần những thông tin sau cho responseGet_Listdevice:
//   - url:https://smarthome.test.makipos.net:3029/devices
//   - headers: {
//           "Authorization":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2M2I1M2M0NDYxMjVkYjAwMDdjYTIwZmMiLCJ1c2VybmFtZSI6IkJNU19hZG1pbiIsInR5cGUiOiJ1c2VyIiwiaWF0IjoxNjcyODI4NTA3LCJleHAiOjEwMzEyODI4NTA3LCJhdWQiOiJodHRwOi8vc2VydmVyLm1ha2lwb3MubmV0OjMwMjgiLCJpc3MiOiJodHRwOi8vc2VydmVyLm1ha2lwb3MubmV0OjMwMjgiLCJzdWIiOiIiLCJqdGkiOiI0MjA5OTUxNS0zZmY2LTQ0OTgtYmMxYS02NDg1MmEzM2U5ZjcifQ.HfJz87PI0G1T9nUF0doesD6sY-KTKSbZuJgaWfWN0Uo"
//         },