package com.example.restaurantreview.controller;

import com.example.restaurantreview.model.Restaurant;
import com.example.restaurantreview.repository.RestaurantRepository;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/restaurants")
public class RestaurantController {

    private final RestaurantRepository repository;

    public RestaurantController(RestaurantRepository repository) {
        this.repository = repository;
    }

    @GetMapping
    public List<Restaurant> getAll() {
        return repository.findAll();
    }

    @PostMapping
    public Restaurant create(@RequestBody Restaurant restaurant) {
        return repository.save(restaurant);
    }
}
