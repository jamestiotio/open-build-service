class BuildStatusBadgeComponent < ApplicationComponent
  def initialize(status:, text:)
    super

    @status = status
    @text = text
  end

  ICON = {
    succeeded: 'fa-check',
    failed: 'fa-xmark',
    unresolvable: 'fa-xmark',
    broken: 'fa-xmark',
    blocked: 'fa-shield',
    scheduled: 'fa-hourglass-half',
    dispatching: 'fa-plane-departure',
    building: 'fa-gear',
    signing: 'fa-signature',
    finished: 'fa-check',
    disabled: 'fa-xmark',
    excluded: 'fa-xmark',
    locked: 'fa-lock',
    deleting: 'fa-eraser',
    unknown: 'fa-question'
  }.with_indifferent_access.freeze

  BADGE_COLOR = {
    succeeded: 'text-bg-success',
    failed: 'text-bg-danger',
    unresolvable: 'text-bg-danger',
    broken: 'text-bg-danger',
    blocked: 'text-bg-warning',
    scheduled: 'text-bg-warning',
    dispatching: 'text-bg-warning',
    building: 'text-bg-warning',
    signing: 'text-bg-warning',
    finished: 'text-bg-warning',
    disabled: 'text-bg-light border',
    excluded: 'text-bg-light border',
    locked: 'text-bg-warning',
    deleting: 'text-bg-warning',
    unknown: 'text-bg-warning'
  }.with_indifferent_access.freeze

  def badge
    tag.span(icon.concat(@text), class: ['badge', BADGE_COLOR[@status]])
  end

  def icon
    tag.i(class: ['fa', ICON[@status], 'me-2'])
  end
end
