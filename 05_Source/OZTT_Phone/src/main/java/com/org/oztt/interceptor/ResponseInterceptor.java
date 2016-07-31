package com.org.oztt.interceptor;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

import com.org.oztt.contants.CommonConstants;

public class ResponseInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
            ModelAndView modelAndView) throws Exception {
        Locale locale = (Locale) request.getSession().getAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME);
        String language = "";
        if (locale == null) {

            //            if ("en".equals(request.getLocale().getLanguage())) {
            //                language = "en_US";
            //            }
            //            else {
            //                language = "zh_CN";
            //            }
            language = "zh_CN";
            request.getSession().setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME,
                    new Locale("zh", "CN"));
        }
        else {
            language = locale.getLanguage() + "_" + locale.getCountry();
        }
        if (modelAndView != null) {
            modelAndView.addObject("currentUserId",
                    request.getSession().getAttribute(CommonConstants.SESSION_CUSTOMERNO));
            modelAndView.addObject("currentUserName",
                    request.getSession().getAttribute(CommonConstants.SESSION_CUSTOMERNAME));
            modelAndView.addObject("languageSelf", language);
        }

    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
            throws Exception {

    }

}
