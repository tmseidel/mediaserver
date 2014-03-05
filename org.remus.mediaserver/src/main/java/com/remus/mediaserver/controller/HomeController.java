package com.remus.mediaserver.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.remus.mediaserver.service.ExecutionService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory
			.getLogger(HomeController.class);

	@Inject
	private ExecutionService executionService;

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String programs(final Locale locale, final Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);

		final Date date = new Date();
		final DateFormat dateFormat = DateFormat.getDateTimeInstance(
				DateFormat.LONG, DateFormat.LONG, locale);

		final String formattedDate = dateFormat.format(date);

		model.addAttribute("serverTime", formattedDate);

		return "home";
	}

}
