package com.example.restaurantreview.controller;

import com.example.restaurantreview.model.Restaurant;
import com.example.restaurantreview.repository.RestaurantRepository;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/restaurant-review")
public class RestaurantController {

    private final RestaurantRepository repository;

    public RestaurantController(RestaurantRepository repository) {
        this.repository = repository;
    }

    // READ
    @GetMapping
    public List<Restaurant> getAll() {
        return repository.findAll();
    }

    // READ (один запис по ID)
    @GetMapping("/{id}")
    public Restaurant getById(@PathVariable("id") Long id) {
        return repository.findById(id)
                .orElseThrow(() -> new RuntimeException("Restaurant not found with id " + id));
    }

    // CREATE
    @PostMapping
    public Restaurant create(@RequestBody Restaurant restaurant) {
        return repository.save(restaurant);
    }

    // UPDATE
    @PutMapping("/{id}")
    public Restaurant update(@PathVariable("id") Long id, @RequestBody Restaurant updated) {
        Restaurant restaurant = repository.findById(id)
                .orElseThrow(() -> new RuntimeException("Restaurant not found"));
        restaurant.setName(updated.getName());
        restaurant.setCuisine(updated.getCuisine());
        return repository.save(restaurant);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable("id") Long id) {
        repository.deleteById(id);
    }
}
