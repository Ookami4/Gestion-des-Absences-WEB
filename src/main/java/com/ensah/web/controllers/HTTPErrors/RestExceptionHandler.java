package com.ensah.web.controllers.HTTPErrors;

import javax.persistence.EntityNotFoundException;

import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

import com.ensah.core.exceptions.EntityNotUnique;
import com.ensah.core.exceptions.ValidationErrorCustom;
@Order(Ordered.HIGHEST_PRECEDENCE)
@ControllerAdvice
public class RestExceptionHandler extends ResponseEntityExceptionHandler {
	  @Override
	   protected ResponseEntity<Object> handleHttpMessageNotReadable(HttpMessageNotReadableException ex, HttpHeaders headers, HttpStatus status, WebRequest request) {
	       String error = "Malformed JSON request";
	       return buildResponseEntity(new APIError(HttpStatus.BAD_REQUEST, error, ex));
	   }

	   private ResponseEntity<Object> buildResponseEntity(APIError apiError) {
	       return new ResponseEntity<>(apiError, apiError.getStatus());
	   }
	   
	   @ExceptionHandler(EntityNotUnique.class)
	   protected ResponseEntity<Object> handleEntityNotFound(EntityNotUnique ex) {
	       APIError apiError = new APIError(HttpStatus.FORBIDDEN, ex);
	       apiError.setMessage(ex.getMessage());
	       return buildResponseEntity(apiError);
	   }
	   
	   @ExceptionHandler(ValidationErrorCustom.class)
	   protected ResponseEntity<Object> handleValidationErrorCustom(ValidationErrorCustom ex){
	       APIError apiError = new APIError(HttpStatus.EXPECTATION_FAILED, ex);
	       apiError.setMessage(ex.getMessage());
	       return buildResponseEntity(apiError);

	   }
	   
	   @ExceptionHandler(EntityNotFoundException.class)
	   protected ResponseEntity<Object> handleEntityNotfound(EntityNotFoundException ex){
	       APIError apiError = new APIError(HttpStatus.FORBIDDEN, ex);
	       apiError.setMessage(ex.getMessage());
	       return buildResponseEntity(apiError);
	   }
	   
	   @ExceptionHandler(com.ensah.genericdao.EntityNotFoundException.class)
	   protected ResponseEntity<Object> handleEntityNotfound(com.ensah.genericdao.EntityNotFoundException ex){
	       APIError apiError = new APIError(HttpStatus.FORBIDDEN, ex);
	       apiError.setMessage(ex.getMessage());
	       return buildResponseEntity(apiError);
	   }
	   
}
