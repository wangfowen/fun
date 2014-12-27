package controllers

import play.api._
import play.api.mvc._
import play.api.data._
import play.api.data.Forms._
import com.avaje.ebean.Ebean
import com.codahale.jerkson._
import java.text.SimpleDateFormat
import database.api._
import database.models._
import services._

object Events extends Controller {
	def shortDateFormat = new SimpleDateFormat("MM/dd/yyyy")

	def index = Action {

		Ok(views.html.events.index())
	}

	def create = Action { implicit request =>
		val emailForm = Form(("email" -> text))
		var email = emailForm.bindFromRequest.get
		var account = AccountsAPI.getAccountByEmail(email, true)
		val messageType = request.getQueryString("message").getOrElse("0")
		Ok(views.html.events.create(account.getId(), email, messageType))
	}

	def selectTimeGet = Action { implicit request =>
		val createEventForm = Form(
			tuple (
				"userId" -> number,
				"eventId" -> number
			)
		)
		var formData = createEventForm.bindFromRequest
		var eventData = formData.get
		var event = EventsAPI.getEventById(eventData._2)

		Ok(views.html.events.select_time(eventData._1, event.getId()))
	}

	def selectTimePost = Action { implicit request =>
		val createEventForm = Form(
			tuple (
				"userId" -> number,
				"name" -> text,
				"location" -> optional(text),
				"description" -> optional(text),
				"cutoff" -> text,
				"invitees" -> text
			)
		)
		var formData = createEventForm.bindFromRequest
		var eventData = formData.get

		var event = EventsAPI.bindEventData(
			Map(
				"name" -> eventData._2,
				"location" -> eventData._3.getOrElse(null),
				"description" -> eventData._4.getOrElse(null),
				"cutoffDate" -> shortDateFormat.parse(eventData._5)
			)
		)


		var owner = AccountsAPI.getAccountById(eventData._1)
		EventsAPI.save(event)

		Mailer.sendEmail(owner.getEmail(), "You have created the event " + event.getName() + "!",
				"Access your event <a href='http://" + request.headers("Host") +
				"/select_time?userId=" + owner.getId() + "&eventId=" + event.getId() + "'>here</a>!")

		var inviteeStr = eventData._6
		if(inviteeStr != null){
			var inviteeList = Json.parse[List[String]](inviteeStr)
			for(i <- 0 until inviteeList.length){
				var p = AccountsAPI.getAccountByEmail(inviteeList(i))
				Mailer.sendEmail(p.getEmail(), "You have been invited to " + event.getName() + "!",
						"Please choose your availabilities <a href='http://" + request.headers("Host") +
						"/select_time?userId=" + p.getId() + "&eventId=" + event.getId() + "'>here</a>!")
				event.addParticipant(p)
			}
		}
		event.addParticipant(owner)
		event.setOwner(owner)

		EventsAPI.save(event)
		Ok(views.html.events.select_time(eventData._1, event.getId()))
	}
}