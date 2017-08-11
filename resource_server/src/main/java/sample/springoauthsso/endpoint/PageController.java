package sample.springoauthsso.endpoint;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class PageController {

    @RequestMapping("/home")
    public String homePage() {
        return "Home page";
    }

    @RequestMapping("/samplePage")
    public String samplePage() {
        return "Sample page";
    }

}
