package sample.springoauthsso.endpoint.user;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/user")
public class UserPhotoController {

    @RequestMapping("/photo")
    public String fetchPhotos() {
        return "List of photos";
    }

}
