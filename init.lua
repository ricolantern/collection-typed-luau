-- !strict

export type Type<TKey, TValue> = {
    items: {[TKey]: TValue},
    _count: number,
    __index: Type<TKey, TValue>,

    new:        (items: {[TKey]: TValue})                      -> Type<TKey, TValue>,
    range:      (from: number, to: number, step: number)       -> Type<number, number>,
    Add:        (self: Type<TKey, TValue>, value: TValue)      -> Type<TKey, TValue>,
    Append:     (self: Type<TKey, TValue>, ...TValue)          -> Type<TKey, TValue>,
    Prepend:    (self: Type<TKey, TValue>, ...TValue)          -> Type<TKey, TValue>,
    Remove:     (self: Type<TKey, TValue>, value: TValue)      -> Type<TKey, TValue>,
    Forget:     (self: Type<TKey, TValue>, key: TKey)          -> Type<TKey, TValue>,
    Clear:      (self: Type<TKey, TValue>)                     -> Type<TKey, TValue>,
    Search:     (self: Type<TKey, TValue>, value: TValue)      -> TKey,
    Get:        (self: Type<TKey, TValue>, key: TKey)          -> TValue|nil,
    HasKey:     (self: Type<TKey, TValue>, key: TKey)          -> boolean,
    HasValue:   (self: Type<TKey, TValue>, value: TValue)      -> boolean,
    All:        (self: Type<TKey, TValue>)                     -> {[TKey]: TValue},
    Keys:       (self: Type<TKey, TValue>)                     -> {[number]: TKey},
    Values:     (self: Type<TKey, TValue>)                     -> {[number]: TValue},
    __iter:     (self: Type<TKey, TValue>)                     -> (typeof(next), {[TKey]: TValue}),
    __len:      (self: Type<TKey, TValue>)                     -> number,
}

local Collection: Type<any, any> = {}
Collection.__index = Collection

function Collection.new<TKey, TValue>(items: {[TKey]: TValue}): Type<TKey, TValue>
    local self: Type<TKey, TValue> = setmetatable({}, Collection)

    self.items = items
    self._count = 0

    for _, _ in items do self._count += 1 end

    return self
end

function Collection.range(from: number, to: number, step: number|nil): Type<number, number>
    local items: {[number]: number} = {}

    if step == nil then step = 1 end

    for i = from, to, step do items[#items + 1] = i end

    return Collection.new(items)
end

function Collection:Add<TKey, TValue>(key: TKey, value: TValue): Type<TKey, TValue>
    if self.items[key] == nil then
        self._count += 1
    end

    self.items[key] = value

    return self
end

function Collection:Append<TKey, TValue>(...: TValue): Type<TKey, TValue>
    for _, value in ... do
        self._count += 1
        self.items[self._count] = value
    end

    return self
end

function Collection:Prepend<TKey, TValue>(...: TValue): Type<TKey, TValue>
    for _, value in ... do
        self._count += 1
        table.insert(self.items, 1, value)
    end

    return self
end

function Collection:Remove<TKey, TValue>(value: TValue): Type<TKey, TValue>
    for k, v in self.items do
        if v == value then
            self._count -= 1
            table.Remove(self.items, k)

            break
        end
    end

    return self
end

function Collection:Forget<TKey, TValue>(key: TKey): Type<TKey, TValue>
    for k, _ in self.items do
        if k == key then
            self._count -= 1
            table.Remove(self.items, k)

            break
        end
    end

    return self
end

function Collection:Clear<TKey, TValue>(): Type<TKey, TValue>
    self._count = 0
    table.clear(self.items)
end

function Collection:Search<TKey, TValue>(value: TValue): TKey|nil
    for k, v in self.items do if v == value then return k end end

    return nil
end

function Collection:Get<TKey, TValue>(key: TKey): TValue|nil
    return self.items[key] or nil
end

function Collection:HasKey<TKey>(key: TKey): boolean
    return self.items[key] ~= nil
end

function Collection:HasValue<TValue>(value: TValue): boolean
    for _, v in self.items do if v == value then return true end end

    return false
end

function Collection:All<TKey, TValue>(): {[TKey]: TValue}
    return self.items
end

function Collection:Keys<TKey>(): {[number]: TKey}
    local keys = {}

    for k, _ in self.items do
        table.insert(keys, k)
    end

    return keys
end

function Collection:Values<TValue>(): {[number]: TValue}
    local values = {}

    for _, v in self.items do
        table.insert(values, v)
    end

    return values
end

function Collection:__iter<TKey, TValue>(): (typeof(next), {[TKey]: TValue})
    return next, self.items
end

function Collection:__len(): number
    return self._count
end

return Collection