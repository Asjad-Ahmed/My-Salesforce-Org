@RestResource(urlMapping='/myservice')
global class MyService {
    @HttpGet
    global static String doGet() {
        
        return 'get Service Webhook';
    }
}