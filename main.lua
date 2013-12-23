function love.load()
  hero = {}
  hero.x = 300
  hero.y = 450
  hero.width = 100
  hero.speed = 100
  hero.shots = {}

  enemies = {}

  for i = 0, 7 do
    enemy = {}
    enemy.width = 40
    enemy.height = 20
    enemy.x = i * (enemy.width + 60) + 100
    enemy.y = enemy.height + 100

    table.insert(enemies, enemy)
  end
end

function love.update(dt)
  for i, v in ipairs(enemies) do
    v.y = v.y + dt

    if v.y > 465 then
    end
  end

  local remEnemy = {}
  local remShot = {}

  for i, v in ipairs(hero.shots) do
    v.y = v.y - dt * 100

    if v.y < 0 then
      table.insert(remShot, i)
    end

    for ii, vv in ipairs(enemies) do
      if CheckCollision(v.x, v.y, 2, 5, vv.x, vv.y, vv.width, vv.height) then
        table.insert(remEnemy, ii)
        table.insert(remShot, i)
      end
    end
  end

  if love.keyboard.isDown('left') then
    hero.x = hero.x - hero.speed * dt
  elseif love.keyboard.isDown('right') then
    hero.x = hero.x + hero.speed * dt
  end

  for i, v in ipairs(remEnemy) do
    table.remove(enemies, v)
  end

  for i, v in ipairs(remShot) do
    table.remove(hero.shots, v)
  end
end

function love.draw()
  love.graphics.setColor(0, 255, 0, 255)
  love.graphics.rectangle('fill', 0, 465, 800, 150)

  love.graphics.setColor(255, 255, 0, 255)
  love.graphics.rectangle('fill', hero.x, hero.y, 30, 15)

  love.graphics.setColor(0, 255, 255, 255)
  for i, v in ipairs(enemies) do
    love.graphics.rectangle('fill', v.x, v.y, v.width, v.height)
  end

  love.graphics.setColor(255, 255, 255, 255)
  for i, v in ipairs(hero.shots) do
    love.graphics.rectangle('fill', v.x, v.y, 2, 5)
  end
end

function shoot()
  local shot = {}
  shot.x = hero.x + hero.width / 2
  shot.y = hero.y

  table.insert(hero.shots, shot)
end

function love.keyreleased(key)
  if (key == ' ') then
    shoot()
  end
end
function CheckCollision(ax1,ay1,aw,ah, bx1,by1,bw,bh)
  local ax2, ay2, bx2, by2 = ax1 + aw, ay1 + ah, bx1 + bw, by1 + bh
  return ax1 < bx2 and ax2 < bx1 and ay1 < by2 and ay2 < by1
end
