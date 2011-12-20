module Physics

  class Collidable
    def collides?(other)
    end
  end

  def circle_circle_collides?(entity_one, entity_two)
      dx = entity_one.x - entity_two.x
      dy = entity_one.y - entity_two.y
      dr = (entity_one.width/2.0*entity_one.scale +
            entity_two.width/2.0*entity_two.scale)

      dx**2 + dy**2 < dr**2
  end

end
