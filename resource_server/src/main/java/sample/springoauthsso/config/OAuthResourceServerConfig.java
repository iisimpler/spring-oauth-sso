package sample.springoauthsso.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.oauth2.config.annotation.web.configuration.EnableResourceServer;
import org.springframework.security.oauth2.config.annotation.web.configuration.ResourceServerConfigurerAdapter;
import org.springframework.security.oauth2.config.annotation.web.configurers.ResourceServerSecurityConfigurer;
import org.springframework.security.web.util.matcher.RequestMatcher;

import javax.servlet.http.HttpServletRequest;
import java.util.Optional;

@Configuration
@EnableResourceServer
public class OAuthResourceServerConfig extends ResourceServerConfigurerAdapter {

    @Override
    public void configure(ResourceServerSecurityConfigurer resources) throws Exception {
    }

    @Override
    public void configure(HttpSecurity http) throws Exception {
        http
                // Since we want the protected resources to be accessible in the UI as well we need
                // session creation to be allowed (it's disabled by default in 2.0.6)
                .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED)
                .and()
                .requestMatchers().anyRequest()  //API模式
                .and()
                //.requestMatcher(BearerTokenRequestMatcher.build()) // 授权码模式必须
                .authorizeRequests()
                .anyRequest().authenticated()
        ;
    }

    public static class BearerTokenRequestMatcher implements RequestMatcher {

        private static BearerTokenRequestMatcher build() {
            return new BearerTokenRequestMatcher();
        }

        @Override
        public boolean matches(HttpServletRequest request) {
            return Optional.ofNullable(request.getHeader("Authorization"))
                    .map(value -> value.startsWith("Bearer"))
                    .orElse(false);
        }
    }
}
